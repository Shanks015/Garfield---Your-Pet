import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final presenceServiceProvider = Provider<PresenceService>((ref) {
  final ps = PresenceService();
  ref.onDispose(() => ps.dispose());
  return ps;
});

class PresenceService with WidgetsBindingObserver {
  final _channel = Supabase.instance.client.channel('presence:flowday');
  final String _deviceId;  // 'desktop' or 'mobile'
  bool _isActive = false;

  // Grace period before physically tearing down the WebSocket
  static const _socketTeardownDelay = Duration(minutes: 5);
  Timer? _teardownTimer;
  bool _isSocketOpen = true;

  PresenceService() : _deviceId = _resolveDeviceId() {
    WidgetsBinding.instance.addObserver(this);
  }

  static String _resolveDeviceId() {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return 'desktop';
    }
    return 'mobile';
  }

  Future<void> initialize(String userId) async {
    _channel
      .onPresenceSync((payload) => _onPresenceChange())
      .onPresenceJoin((payload) => _onPresenceChange())
      .onPresenceLeave((payload) => _onPresenceChange())
      .subscribe(
        (status, _) async {
          if (status == RealtimeSubscribeStatus.subscribed) {
            await _broadcastActive();
          }
        },
      );
  }

  void _onPresenceChange() {
    debugPrint('Supabase Realtime Presence state changed');
  }

  Future<void> _broadcastActive() async {
    // Cancel any pending socket teardown — user is back
    _teardownTimer?.cancel();
    _teardownTimer = null;

    // If the socket was physically torn down during extended background,
    // re-subscribe before tracking presence
    if (!_isSocketOpen) {
      _channel.subscribe((status, _) async {
        if (status == RealtimeSubscribeStatus.subscribed) {
          _isSocketOpen = true;
          await _trackPresence();
        }
      });
    } else {
      await _trackPresence();
    }
  }

  Future<void> _trackPresence() async {
    await _channel.track({
      'device': _deviceId,
      'active_at': DateTime.now().toIso8601String(),
    });
    _isActive = true;
    debugPrint('Device $_deviceId tracked as ACTIVE');
  }

  Future<void> _broadcastInactive() async {
    // Step 1: immediately remove from presence state
    await _channel.untrack();
    _isActive = false;
    debugPrint('Device $_deviceId tracked as INACTIVE');

    // Step 2: schedule physical WebSocket teardown after grace period
    _teardownTimer?.cancel();
    _teardownTimer = Timer(_socketTeardownDelay, () async {
      await _channel.unsubscribe();
      _isSocketOpen = false;
      debugPrint('Supabase WebSocket connection closed during backgrounding');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _broadcastActive();
    } else if (state == AppLifecycleState.paused ||
               state == AppLifecycleState.inactive ||
               state == AppLifecycleState.detached) {
      _broadcastInactive();
    }
  }

  bool get shouldFireNotification {
    final presences = _channel.presenceState();
    
    // Find which devices are active right now
    final activeDevices = presences
        .expand((state) => state.presences)
        .map((p) => p.payload['device'] as String?)
        .whereType<String>()
        .toSet();

    debugPrint('Active devices in Presence channel: $activeDevices');

    // Desktop presence takes priority: if desktop is active, mobile suppresses
    if (_deviceId == 'mobile' && activeDevices.contains('desktop')) {
      return false;
    }
    return true;
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _teardownTimer?.cancel();
    _channel.unsubscribe();
  }
}
