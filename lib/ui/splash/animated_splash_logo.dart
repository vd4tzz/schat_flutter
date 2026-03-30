import 'package:flutter/material.dart';

class AnimatedSplashLogo extends StatefulWidget {
  const AnimatedSplashLogo({super.key, this.size = 150});

  final double size;

  @override
  State<AnimatedSplashLogo> createState() => _AnimatedSplashLogoState();
}

class _AnimatedSplashLogoState extends State<AnimatedSplashLogo>
    with TickerProviderStateMixin {
  late List<AnimationController> _dotControllers;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();

    _dotControllers = List.generate(
      3,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 450),
      ),
    );

    _dotAnimations = _dotControllers
        .map(
          (c) => Tween<double>(
            begin: 0,
            end: -10,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut)),
        )
        .toList();

    _startWave();
  }

  void _startWave() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) _dotControllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _dotControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: _ChatBubblePainter(),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Center(
          child: Padding(
            // nudge dots up slightly to sit inside the bubble body
            padding: EdgeInsets.only(bottom: widget.size * 0.2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final dotSize = widget.size * 0.12;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: dotSize * 0.35),
                  child: AnimatedBuilder(
                    animation: _dotAnimations[i],
                    builder: (_, child) => Transform.translate(
                      offset: Offset(0, _dotAnimations[i].value),
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final w = size.width;
    final h = size.height;

    // bubble body: rounded rect occupying top ~78% of height
    final bodyBottom = h * 0.72;
    final radius = Radius.circular(w * 0.20);
    final bodyRect = RRect.fromLTRBR(0, 0, w, bodyBottom, radius);
    canvas.drawRRect(bodyRect, paint);

    // tail: triangle at bottom-right
    final tailPath = Path();
    final tailLeft = w * 0.52;
    final tailRight = w * 0.72;
    final tailTip = Offset(w * 0.68, h * 0.94);

    tailPath.moveTo(tailLeft, bodyBottom);
    tailPath.lineTo(tailRight, bodyBottom);
    tailPath.lineTo(tailTip.dx, tailTip.dy);
    tailPath.close();
    canvas.drawPath(tailPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
