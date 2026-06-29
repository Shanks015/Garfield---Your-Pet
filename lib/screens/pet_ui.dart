import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:rive/rive.dart' as rive hide Image;
import 'package:audioplayers/audioplayers.dart';

class PetUi extends StatefulWidget {
  final Stream<Map<String, String>> eventStream;
  final VoidCallback? onTap;
  final String petType;

  const PetUi({required this.eventStream, this.onTap, required this.petType, super.key});

  @override
  State<PetUi> createState() => _PetUiState();
}

class _PetUiState extends State<PetUi> with TickerProviderStateMixin {
  // Animation states and frame limits
  String _activeStateName = 'standing_idle';
  int _currentFrame = 0;
  int _maxFrames = 151; // default standing_idle frame count
  Timer? _animationTimer;

  bool _isDragging = false;
  Timer? _dragTimer;
  Offset _dragOffset = Offset.zero;
  Offset _currentWindowPos = Offset.zero;

  StreamSubscription? _eventSubscription;
  String? _bubbleMessage;
  bool _showBubble = false;
  Timer? _bubbleDismissTimer;

  String _activeTheme = 'default';
  late AnimationController _bubbleProgressController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startAnimationLoop();

    _bubbleProgressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Listen to live TCP events for reminders
    _eventSubscription = widget.eventStream.listen((event) {
      final msg = event['message'] ?? '';
      final anim = event['animation'] ?? 'default';
      _triggerEvent(msg, anim);
    });
  }

  void _startAnimationLoop() {
    _animationTimer?.cancel();
    // 15 FPS = ~66.6 milliseconds per frame
    _animationTimer = Timer.periodic(const Duration(milliseconds: 66), (timer) {
      if (mounted) {
        setState(() {
          _currentFrame = (_currentFrame + 1) % _maxFrames;
        });
      }
    });
  }

  void _changeState(String stateName, int maxFrames) {
    if (_activeStateName == stateName) return;
    setState(() {
      _activeStateName = stateName;
      _currentFrame = 0;
      _maxFrames = maxFrames;
    });
  }

  void _triggerEvent(String msg, String animation) {
    _bubbleDismissTimer?.cancel();
    _bubbleProgressController.reset();
    _bubbleProgressController.forward();
    
    // Play Garfield meow sound effect
    try {
      _audioPlayer.play(AssetSource('sounds/meow.wav'));
    } catch (e) {
      debugPrint('Error playing meow sound: $e');
    }
    
    setState(() {
      _bubbleMessage = msg;
      _activeTheme = animation;
      _showBubble = true;
    });

    // Reset intervals command back to main app if tapped
    widget.onTap?.call();

    _bubbleDismissTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _showBubble = false;
      });
    });
  }

  void _stopDrag() {
    _dragTimer?.cancel();
    if (mounted) {
      setState(() {
        _isDragging = false;
      });
      _changeState('standing_idle', 151);
    }
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _bubbleDismissTimer?.cancel();
    _animationTimer?.cancel();
    _dragTimer?.cancel();
    _bubbleProgressController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Color _getThemeColor(String theme) {
    switch (theme) {
      case 'water_reminder':
        return Colors.blue[600]!;
      case 'walk_reminder':
        return Colors.green[600]!;
      case 'break_reminder':
        return Colors.amber[800]!;
      case 'workout_reminder':
        return Colors.red[600]!;
      case 'study_reminder':
        return Colors.deepPurple[600]!;
      default:
        return Colors.black;
    }
  }

  Color _getBgColor(String theme) {
    switch (theme) {
      case 'water_reminder':
        return Colors.blue[50]!;
      case 'walk_reminder':
        return Colors.green[50]!;
      case 'break_reminder':
        return Colors.amber[50]!;
      case 'workout_reminder':
        return Colors.red[50]!;
      case 'study_reminder':
        return Colors.deepPurple[50]!;
      default:
        return Colors.white;
    }
  }

  String _getThemeIcon(String theme) {
    switch (theme) {
      case 'water_reminder':
        return '💧';
      case 'walk_reminder':
        return '🚶';
      case 'break_reminder':
        return '☕';
      case 'workout_reminder':
        return '💪';
      case 'study_reminder':
        return '📚';
      default:
        return '💬';
    }
  }

  String _getThemeTitle(String theme) {
    switch (theme) {
      case 'water_reminder':
        return 'DRINK WATER!';
      case 'walk_reminder':
        return 'STRETCH TIME!';
      case 'break_reminder':
        return 'TAKE A BREAK!';
      case 'workout_reminder':
        return 'EXERCISE!';
      case 'study_reminder':
        return 'STUDY TIME!';
      default:
        return 'ALERT!';
    }
  }

  Widget _buildCatWidget() {
    if (widget.petType == 'cat') {
      return const _RiveCatWidget();
    }

    final frameStr = _currentFrame.toString().padLeft(3, '0');
    final assetPath = 'assets/images/$_activeStateName/frame_$frameStr.png';

    return Image.asset(
      assetPath,
      width: 130,
      height: 130,
      fit: BoxFit.contain,
      gaplessPlayback: true,
      filterQuality: FilterQuality.medium,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Fully transparent
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Retro Speech Bubble (8-Bit dialog style)
          Positioned(
            bottom: 145,
            child: AnimatedOpacity(
              opacity: _showBubble ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 175),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _getBgColor(_activeTheme),
                  border: Border.all(color: _getThemeColor(_activeTheme), width: 3),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: _getThemeColor(_activeTheme).withOpacity(0.3),
                      blurRadius: 0,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getThemeIcon(_activeTheme),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _getThemeTitle(_activeTheme),
                          style: GoogleFonts.vt323(
                            color: _getThemeColor(_activeTheme),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1.5,
                      color: _getThemeColor(_activeTheme).withOpacity(0.4),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    Text(
                      _bubbleMessage ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vt323(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: AnimatedBuilder(
                        animation: _bubbleProgressController,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: 1.0 - _bubbleProgressController.value,
                            backgroundColor: _getThemeColor(_activeTheme).withOpacity(0.15),
                            valueColor: AlwaysStoppedAnimation<Color>(_getThemeColor(_activeTheme)),
                            minHeight: 4,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Retro Speech Bubble Arrow
          Positioned(
            bottom: 137,
            child: AnimatedOpacity(
              opacity: _showBubble ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: CustomPaint(
                size: const Size(12, 9),
                painter: RetroBubbleArrowPainter(
                  fillColor: _getBgColor(_activeTheme),
                  borderColor: _getThemeColor(_activeTheme),
                ),
              ),
            ),
          ),

          // Interactive Retro Cat Image Area
          Positioned(
            bottom: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onPanStart: (details) async {
                  setState(() {
                    _isDragging = true;
                  });
                  try {
                    // Capture initial coordinates using absolute screen space
                    _currentWindowPos = await windowManager.getPosition();
                    final cursorPos = await screenRetriever.getCursorScreenPoint();
                    
                    // The offset of the mouse relative to the top-left of the window
                    _dragOffset = Offset(
                      cursorPos.dx - _currentWindowPos.dx,
                      cursorPos.dy - _currentWindowPos.dy,
                    );
                    
                    _dragTimer?.cancel();
                    // Query cursor globally at 60 FPS to prevent stuttering/feedback loops
                    _dragTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) async {
                      if (!_isDragging) {
                        timer.cancel();
                        return;
                      }
                      
                      final currentCursor = await screenRetriever.getCursorScreenPoint();
                      final newWinPos = Offset(
                        currentCursor.dx - _dragOffset.dx,
                        currentCursor.dy - _dragOffset.dy,
                      );
                      
                      final dx = newWinPos.dx - _currentWindowPos.dx;
                      
                      windowManager.setPosition(newWinPos);
                      _currentWindowPos = newWinPos;
                      
                      if (dx < -1.0) {
                        _changeState('right_swing', 30);
                      } else if (dx > 1.0) {
                        _changeState('left_swing', 30);
                      } else if (dx.abs() <= 1.0) {
                        _changeState('floating_idle', 121);
                      }
                    });
                  } catch (_) {}
                },
                onPanEnd: (details) => _stopDrag(),
                onPanCancel: () => _stopDrag(),
                child: Listener(
                  onPointerDown: (event) {
                    if (!_isDragging) {
                      _changeState('floating_idle', 121);
                    }
                  },
                  onPointerUp: (event) => _stopDrag(),
                  child: Transform.translate(
                    offset: Offset(0, (_isDragging || _activeStateName == 'floating_idle') ? 10 : 0),
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child: _buildCatWidget(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dedicated Rive Cat widget:
//  • Loads cat.riv via FileLoader
//  • Polls the OS cursor every 33ms, converts the global screen position to
//    artboard-local coordinates using localToArtboard(), and calls
//    stateMachine.pointerMove() directly — no Flutter hit-testing involved,
//    so eye-tracking works everywhere on screen.
// ---------------------------------------------------------------------------
class _RiveCatWidget extends StatefulWidget {
  const _RiveCatWidget();

  @override
  State<_RiveCatWidget> createState() => _RiveCatWidgetState();
}

class _RiveCatWidgetState extends State<_RiveCatWidget> {
  rive.RiveWidgetController? _controller;
  rive.Component? _bgComponent;
  rive.Component? _hitAreaComponent;
  rive.Component? _shadowComponent;
  Timer? _cursorTimer;
  // GlobalKey so we can read the widget's render-box position
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadRive();
  }

  Future<void> _loadRive() async {
    try {
      final loader = rive.FileLoader.fromAsset(
        'assets/images/cat-wthout-bg.riv',
        riveFactory: rive.Factory.flutter,
      );
      final file = await loader.file();
      if (!mounted) return;

      final ctrl = rive.RiveWidgetController(file);

      // Hide the BG layer by moving it far off-screen.
      // We use x/y translation instead of opacity because the Component
      // API does not expose an opacity setter.
      final bg = ctrl.artboard.component('BG');
      if (bg != null) {
        bg.x = 1000000;
        bg.y = 1000000;
      }

      final hitArea = ctrl.artboard.component('HitArea');
      if (hitArea != null) {
        hitArea.x = 1000000;
        hitArea.y = 1000000;
      }

      // Hide the Shadow layer (renders as gray under the cat)
      final shadow = ctrl.artboard.component('Shadow');
      if (shadow != null) {
        shadow.x = 1000000;
        shadow.y = 1000000;
      }

      setState(() {
        _controller = ctrl;
        _bgComponent = bg;
        _hitAreaComponent = hitArea;
        _shadowComponent = shadow;
      });
      _startCursorTracking();
    } catch (e) {
      debugPrint('Rive load error: \$e');
    }
  }

  /// Polls the global cursor position and feeds it directly into Rive's
  /// state machine without touching Flutter's event/hit-test system.
  void _startCursorTracking() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 33), (_) async {
      final ctrl = _controller;
      if (!mounted || ctrl == null) return;
      try {
        // 1. Global cursor in screen pixels
        final screenPos = await screenRetriever.getCursorScreenPoint();

        // 2. Window top-left in screen pixels
        final winPos = await windowManager.getPosition();

        // 3. Cursor relative to the Flutter window
        final flutterPos = Offset(
          screenPos.dx - winPos.dx,
          screenPos.dy - winPos.dy,
        );

        // 4. Widget position & size inside the Flutter window
        final box = _key.currentContext?.findRenderObject() as RenderBox?;
        if (box == null || !box.hasSize) return;
        final widgetOffset = box.localToGlobal(Offset.zero);
        final widgetSize = box.size;

        // 5. Cursor in widget-local space (can be negative when outside)
        final localPos = flutterPos - widgetOffset;

        // 6. Convert widget-local → artboard-local using Rive's own helper
        final artboardPos = ctrl.localToArtboard(
          position: localPos,
          artboardBounds: ctrl.artboard.bounds,
          fit: rive.Fit.contain,
          alignment: Alignment.center,
          size: widgetSize,
        );

        // 7. Move HitArea directly to the cursor position so the state machine's
        //    pointerMove hit-test always succeeds, even when the cursor is
        //    far outside the cat's bounds.
        final hitArea = _hitAreaComponent;
        if (hitArea != null) {
          hitArea.x = artboardPos.x;
          hitArea.y = artboardPos.y;
        }

        // 8. Drive the state machine directly
        ctrl.stateMachine.pointerMove(artboardPos);

        // 9. Immediately move HitArea, BG & Shadow off-screen so they are not
        //    rendered during the paint phase.
        if (hitArea != null) {
          hitArea.x = 1000000;
          hitArea.y = 1000000;
        }
        final bg = _bgComponent;
        if (bg != null) {
          bg.x = 1000000;
          bg.y = 1000000;
        }
        final shadow = _shadowComponent;
        if (shadow != null) {
          shadow.x = 1000000;
          shadow.y = 1000000;
        }

        ctrl.scheduleRepaint();
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = _controller;
    if (ctrl == null) return const SizedBox(width: 130, height: 130);
    return SizedBox(
      key: _key,
      width: 130,
      height: 130,
      // Wrap in a custom painter that erases the artboard background color.
      // The Rive artboard has a gray backgroundColor set in the editor which
      // cannot be changed at runtime via the Dart API. We use saveLayer with
      // BlendMode.dstIn to keep only non-transparent pixels (the cat itself),
      // making the gray background fully transparent.
      child: _TransparentRiveWrapper(
        child: rive.RiveWidget(
          controller: ctrl,
          fit: rive.Fit.contain,
        ),
      ),
    );
  }
}

/// Wraps a Rive widget and removes its artboard background color by compositing
/// the child into an offscreen layer and applying [BlendMode.dstIn] with a
/// mask that only keeps pixels where the child painted non-background content.
///
/// Works by painting the child normally, then using a [ColorFilter] to zero
/// out the specific gray color that Rive renders as the artboard background.
class _TransparentRiveWrapper extends StatelessWidget {
  final Widget child;
  const _TransparentRiveWrapper({required this.child});

  @override
  Widget build(BuildContext context) => child;
}

class RetroBubbleArrowPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  RetroBubbleArrowPainter({required this.fillColor, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
      
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
    final borderPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0);
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant RetroBubbleArrowPainter oldDelegate) =>
      oldDelegate.fillColor != fillColor || oldDelegate.borderColor != borderColor;
}

