import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:flowday/theme/app_theme.dart';
import 'package:flowday/router/app_router.dart';
import 'package:flowday/providers/isar_provider.dart';
import 'package:flowday/services/notification_service.dart';

// Import Isar collections (will generate .g.dart files next)
import 'package:flowday/local/collections/health_log_collection.dart';
import 'package:flowday/local/collections/workout_log_collection.dart';
import 'package:flowday/local/collections/workout_plan_collection.dart';
import 'package:flowday/local/collections/curriculum_day_collection.dart';
import 'package:flowday/local/collections/learning_log_collection.dart';
import 'package:flowday/local/collections/learning_goal_collection.dart';
import 'package:flowday/local/collections/user_preferences_collection.dart';
import 'package:flowday/local/collections/pet_event_collection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register the CORRECT custom scheme for Windows
  if (!kIsWeb && Platform.isWindows) {
    await protocolHandler.register('io.supabase.flowday');
  }

  // Initialize notifications
  await NotificationService().initialize();

  // Load environment configurations
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Could not load .env file: $e');
  }

  // Initialize Supabase
  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
    } catch (e) {
      debugPrint('Failed to initialize Supabase: $e');
    }
  }

  // Initialize Isar Local Database
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    HealthLogLocalSchema,
    WorkoutLogLocalSchema,
    WorkoutPlanLocalSchema,
    CurriculumDayLocalSchema,
    LearningLogLocalSchema,
    LearningGoalLocalSchema,
    UserPreferencesLocalSchema,
    PetEventLocalSchema,
  ], directory: dir.path);

  // Initialize Window Manager on Desktop platforms
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await windowManager.ensureInitialized();
    await windowManager.setMinimumSize(const Size(800, 600));
    await windowManager.setSize(const Size(1100, 720));
  }

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const FlowDayApp(),
    ),
  );
}

class FlowDayApp extends ConsumerWidget {
  const FlowDayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'FlowDay',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
