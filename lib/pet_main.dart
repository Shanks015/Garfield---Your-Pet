import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flowday/local/collections/pet_event_collection.dart';
import 'package:flowday/screens/pet_ui.dart';

// Stream controller to feed the PetUi with real-time TCP socket events
final StreamController<Map<String, String>> _petEventStreamController = StreamController<Map<String, String>>.broadcast();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // Configure a small, transparent, frameless window
  const WindowOptions windowOptions = WindowOptions(
    size: Size(200, 200),
    center: false,
    backgroundColor: Colors.transparent, // Transparent background
    skipTaskbar: true,                   // Hide from main OS taskbar items list
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setHasShadow(false);
    await windowManager.setResizable(false);
    await windowManager.setMaximizable(false);
    await windowManager.setMinimizable(false);
    await windowManager.show();
    
    // Position at bottom-right corner of work area, then offset left to sit on the taskbar next to the system tray
    await windowManager.setAlignment(Alignment.bottomRight);
    final pos = await windowManager.getPosition();
    await windowManager.setPosition(Offset(pos.dx - 120, pos.dy));
  });

  // Initialize pet local Isar instance (in its own subfolder to avoid locks)
  Isar? petIsar;
  try {
    final dir = await getApplicationDocumentsDirectory();
    final petDbPath = Directory('${dir.path}/flowday_pet');
    if (!await petDbPath.exists()) {
      await petDbPath.create(recursive: true);
    }
    petIsar = await Isar.open([
      PetEventLocalSchema,
    ], directory: petDbPath.path, name: 'petIsar');
  } catch (e) {
    debugPrint('Error initializing Pet Isar: $e');
  }

  // Start TCP loopback server on port 50505 to receive notifications from main app
  final localIsar = petIsar;
  try {
    final server = await ServerSocket.bind('127.0.0.1', 50505);
    debugPrint('FlowCat TCP Server running on port 50505');
    server.listen((Socket client) {
      client.listen((List<int> data) async {
        try {
          final payload = utf8.decode(data);
          final map = jsonDecode(payload);
          final String message = map['message'] ?? '';
          final String animation = map['animation'] ?? 'idle';

          // Emit to UI stream immediately for instant feedback
          _petEventStreamController.add({
            'message': message,
            'animation': animation,
          });

          // Also save in local Pet Isar database as backup/log
          if (localIsar != null) {
            final event = PetEventLocal()
              ..message = message
              ..animation = animation
              ..createdAt = DateTime.now();

            await localIsar.writeTxn(() async {
              await localIsar.petEventLocals.put(event);
            });
          }
        } catch (e) {
          debugPrint('Error processing incoming pet event: $e');
        }
      });
    });
  } catch (e) {
    debugPrint('Could not bind FlowCat TCP server: $e');
  }

  runApp(const FlowCatApp());
}

class FlowCatApp extends StatefulWidget {
  const FlowCatApp({super.key});

  @override
  State<FlowCatApp> createState() => _FlowCatAppState();
}

class _FlowCatAppState extends State<FlowCatApp> with TrayListener {
  String _selectedPet = 'garfield';

  @override
  void initState() {
    super.initState();
    trayManager.addListener(this);
    _initSystemTray();
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  Future<void> _initSystemTray() async {
    try {
      // Use the converted Garfield ICO file for Windows system tray compatibility
      await trayManager.setIcon('assets/images/garfield.ico');
      
      final menu = Menu(
        items: [
          MenuItem(key: 'open_main', label: 'Open FlowDay'),
          MenuItem.separator(),
          MenuItem.checkbox(
            key: 'pet_garfield', 
            label: 'Pet: Garfield',
            checked: _selectedPet == 'garfield',
          ),
          MenuItem.checkbox(
            key: 'pet_cat', 
            label: 'Pet: Rive Cat',
            checked: _selectedPet == 'cat',
          ),
          MenuItem.separator(),
          MenuItem(key: 'exit_pet', label: 'Exit Pet'),
        ],
      );
      await trayManager.setContextMenu(menu);
      await trayManager.setToolTip('FlowCat Desktop Companion');
    } catch (e) {
      debugPrint('Failed to initialize system tray: $e');
    }
  }

  // --- TrayListener Callbacks ---

  @override
  void onTrayIconMouseDown() {
    _openMainApp();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu(bringAppToFront: true);
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    if (menuItem.key == 'open_main') {
      _openMainApp();
    } else if (menuItem.key == 'pet_garfield') {
      setState(() {
        _selectedPet = 'garfield';
      });
      _initSystemTray(); // Refresh menu checkboxes
    } else if (menuItem.key == 'pet_cat') {
      setState(() {
        _selectedPet = 'cat';
      });
      _initSystemTray(); // Refresh menu checkboxes
    } else if (menuItem.key == 'exit_pet') {
      await trayManager.destroy();
      windowManager.destroy();
    }
  }

  // Action to request main app to show its window over the loopback TCP socket
  void _openMainApp() async {
    try {
      final socket = await Socket.connect('127.0.0.1', 50506, timeout: const Duration(milliseconds: 500));
      socket.write(jsonEncode({'action': 'show_main_app'}));
      await socket.flush();
      await socket.close();
      debugPrint('Sent show_main_app command to main app socket');
    } catch (e) {
      debugPrint('Main app is not listening or closed: $e');
    }
  }

  // Action to reset reminders in the main app over socket
  void _resetIntervals() async {
    try {
      final socket = await Socket.connect('127.0.0.1', 50506, timeout: const Duration(milliseconds: 500));
      socket.write(jsonEncode({'action': 'reset_intervals'}));
      await socket.flush();
      await socket.close();
      debugPrint('Sent reset command to main app socket');
    } catch (e) {
      debugPrint('Main app is not listening or closed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent, // Fully transparent scaffold
        body: Center(
          child: PetUi(
            eventStream: _petEventStreamController.stream,
            onTap: _resetIntervals,
            petType: _selectedPet,
          ),
        ),
      ),
    );
  }
}
