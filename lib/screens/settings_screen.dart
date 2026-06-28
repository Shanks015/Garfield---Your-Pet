import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flowday/theme/app_theme.dart';
import 'package:flowday/providers/auth_provider.dart';
import 'package:flowday/providers/preferences_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final prefsAsync = ref.watch(userPreferencesProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Settings',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              background: Container(color: AppTheme.surfaceDark),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Profile card ─────────────────────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              AppTheme.primaryGreen.withValues(alpha: 0.2),
                          child: Text(
                            _initials(user?.email),
                            style: const TextStyle(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.email ?? 'Not signed in',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                'FlowDay member',
                                style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Work schedule ─────────────────────────────────────────
                _SectionHeader('Work Schedule'),
                const SizedBox(height: 12),
                prefsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                  data: (prefs) {
                    if (prefs == null) {
                      return const Text(
                        'Loading preferences…',
                        style: TextStyle(color: AppTheme.textSecondary),
                      );
                    }
                    final actions = ref.read(preferencesActionsProvider);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _HourPicker(
                              label: 'Work Start',
                              hour: prefs.workStartHour,
                              onChanged: (h) => actions.updatePreferences(
                                waterIntervalMin: prefs.waterIntervalMin,
                                breakIntervalMin: prefs.breakIntervalMin,
                                walkIntervalMin: prefs.walkIntervalMin,
                                exerciseReminderHour: prefs.exerciseReminderHour,
                                workStartHour: h,
                                workEndHour: prefs.workEndHour,
                              ),
                            ),
                            const Divider(height: 28, color: AppTheme.surfaceMuted),
                            _HourPicker(
                              label: 'Work End',
                              hour: prefs.workEndHour,
                              onChanged: (h) => actions.updatePreferences(
                                waterIntervalMin: prefs.waterIntervalMin,
                                breakIntervalMin: prefs.breakIntervalMin,
                                walkIntervalMin: prefs.walkIntervalMin,
                                exerciseReminderHour: prefs.exerciseReminderHour,
                                workStartHour: prefs.workStartHour,
                                workEndHour: h,
                              ),
                            ),
                            const Divider(height: 28, color: AppTheme.surfaceMuted),
                            _HourPicker(
                              label: 'Exercise Reminder',
                              hour: prefs.exerciseReminderHour,
                              onChanged: (h) => actions.updatePreferences(
                                waterIntervalMin: prefs.waterIntervalMin,
                                breakIntervalMin: prefs.breakIntervalMin,
                                walkIntervalMin: prefs.walkIntervalMin,
                                exerciseReminderHour: h,
                                workStartHour: prefs.workStartHour,
                                workEndHour: prefs.workEndHour,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),

                // ── Data & Sync ───────────────────────────────────────────
                _SectionHeader('Data & Privacy'),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      _SettingsTile(
                        icon: Icons.sync,
                        iconColor: AppTheme.accentBlue,
                        title: 'Sync Data Now',
                        subtitle: 'Push local data to the cloud',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sync triggered in background…')),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 56, color: AppTheme.surfaceMuted),
                      _SettingsTile(
                        icon: Icons.delete_outline,
                        iconColor: AppTheme.accentRed,
                        title: 'Clear Local Cache',
                        subtitle: 'Remove cached data (will re-sync)',
                        onTap: () => _confirmClearCache(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── About ─────────────────────────────────────────────────
                _SectionHeader('About'),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      _SettingsTile(
                        icon: Icons.info_outline,
                        iconColor: AppTheme.textSecondary,
                        title: 'FlowDay',
                        subtitle: 'v1.0.0 · Wellness OS',
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 56, color: AppTheme.surfaceMuted),
                      _SettingsTile(
                        icon: Icons.privacy_tip_outlined,
                        iconColor: AppTheme.textSecondary,
                        title: 'Privacy Policy',
                        subtitle: 'How we use your data',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Sign Out ──────────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _signOut(context),
                    icon: const Icon(Icons.logout, color: AppTheme.accentRed),
                    label: const Text(
                      'Sign Out',
                      style: TextStyle(color: AppTheme.accentRed),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.accentRed),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String? email) {
    if (email == null || email.isEmpty) return '?';
    return email[0].toUpperCase();
  }

  Future<void> _signOut(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
  }

  Future<void> _confirmClearCache(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Local Cache?'),
        content: const Text(
            'All locally-cached data will be removed. Data saved to the cloud will be re-synced on next launch.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style:
                ElevatedButton.styleFrom(backgroundColor: AppTheme.accentRed),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache cleared. Re-sync on next launch.')),
      );
    }
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppTheme.textSecondary,
          letterSpacing: 0.8,
        ),
      );
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: iconColor.withValues(alpha: 0.12),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        title: Text(title,
            style: const TextStyle(
                color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: const TextStyle(
                color: AppTheme.textSecondary, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right,
            color: AppTheme.textSecondary, size: 18),
      );
}

class _HourPicker extends StatelessWidget {
  final String label;
  final int hour;
  final ValueChanged<int> onChanged;
  const _HourPicker(
      {required this.label, required this.hour, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline,
                  color: AppTheme.textSecondary),
              onPressed: hour > 0 ? () => onChanged(hour - 1) : null,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.surfaceMuted,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _formatHour(hour),
                style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline,
                  color: AppTheme.textSecondary),
              onPressed: hour < 23 ? () => onChanged(hour + 1) : null,
            ),
          ],
        ),
      ],
    );
  }

  String _formatHour(int h) {
    final suffix = h >= 12 ? 'PM' : 'AM';
    final display = h % 12 == 0 ? 12 : h % 12;
    return '$display:00 $suffix';
  }
}
