import 'package:flutter/material.dart';

/// A custom painter that draws subtle, stylish basketball court line markings
/// to give screens an authentic arena atmosphere.
class BasketballCourtPainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;

  const BasketballCourtPainter({
    this.lineColor = const Color(0x1AFFFFFF),
    this.strokeWidth = 1.2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Center court circle
    final center = Offset(size.width * 0.5, size.height * 0.35);
    canvas.drawCircle(center, 90, paint);
    canvas.drawCircle(center, 24, paint);

    // Center court line
    canvas.drawLine(
      Offset(0, size.height * 0.35),
      Offset(size.width, size.height * 0.35),
      paint,
    );

    // Three-point arc at the top or bottom
    final arcRect = Rect.fromCircle(
      center: Offset(size.width * 0.5, -40),
      radius: size.width * 0.65,
    );
    canvas.drawArc(arcRect, 0, 3.14159, false, paint);

    // Key / Painted area outline
    final keyRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, 60),
      width: 140,
      height: 120,
    );
    canvas.drawRect(keyRect, paint);

    // Free throw circle
    canvas.drawCircle(Offset(size.width * 0.5, 120), 45, paint);
  }

  @override
  bool shouldRepaint(covariant BasketballCourtPainter oldDelegate) => false;
}

class CourtBackground extends StatelessWidget {
  final Widget child;
  final Color baseColor;

  const CourtBackground({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFF0C0E14),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: baseColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background ambient gradient glow
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF6B00).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2E5BFF).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Subtle court line markings
          CustomPaint(
            painter: BasketballCourtPainter(
              lineColor: Colors.white.withValues(alpha: 0.035),
            ),
          ),
          // Foreground child
          child,
        ],
      ),
    );
  }
}
