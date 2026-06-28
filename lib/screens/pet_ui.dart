import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';
import 'package:screen_retriever/screen_retriever.dart';

class PetUi extends StatefulWidget {
  final Stream<Map<String, String>> eventStream;
  final VoidCallback? onTap;

  const PetUi({required this.eventStream, this.onTap, super.key});

  @override
  State<PetUi> createState() => _PetUiState();
}

class _PetUiState extends State<PetUi> {
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

  @override
  void initState() {
    super.initState();
    _startAnimationLoop();

    // Listen to live TCP events for reminders
    _eventSubscription = widget.eventStream.listen((event) {
      final msg = event['message'] ?? '';
      _triggerEvent(msg);
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

  void _triggerEvent(String msg) {
    _bubbleDismissTimer?.cancel();
    
    setState(() {
      _bubbleMessage = msg;
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
    super.dispose();
  }

  Widget _buildCatWidget() {
    final frameStr = _currentFrame.toString().padLeft(3, '0');
    final assetPath = 'assets/images/$_activeStateName/frame_$frameStr.png';

    return Image.asset(
      assetPath,
      width: 130,
      height: 130,
      fit: BoxFit.contain,
      gaplessPlayback: true, // Prevents white/blank flickers between frames
      filterQuality: FilterQuality.medium, // Crisp and smooth scaling
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
                constraints: const BoxConstraints(maxWidth: 140),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Text(
                  _bubbleMessage ?? '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.vt323(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
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
                painter: RetroBubbleArrowPainter(),
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

class RetroBubbleArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
      
    final borderPaint = Paint()
      ..color = Colors.black
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
