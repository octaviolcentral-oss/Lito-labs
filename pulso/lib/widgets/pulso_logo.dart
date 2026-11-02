import 'package:flutter/material.dart';

class PulsoLogo extends StatelessWidget {
  final double size;
  const PulsoLogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PulsoLogoPainter(),
    );
  }
}

class _PulsoLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF2C3E35);
    final r = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.width * 0.28),
    );
    canvas.drawRRect(r, bg);

    final pulse = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.08
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w * 0.3, h * 0.3);
    path.lineTo(w * 0.3, h * 0.7);
    path.quadraticBezierTo(w * 0.3, h * 0.85, w * 0.5, h * 0.7);
    path.quadraticBezierTo(w * 0.7, h * 0.55, w * 0.5, h * 0.4);
    path.lineTo(w * 0.3, h * 0.3);
    canvas.drawPath(path, pulse);

    final dot = Paint()..color = const Color(0xFFD27D5E);
    canvas.drawCircle(Offset(w * 0.72, h * 0.35), size.width * 0.08, dot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
