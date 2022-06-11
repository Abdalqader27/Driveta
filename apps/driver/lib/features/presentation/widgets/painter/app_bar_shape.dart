import 'package:flutter/material.dart';

class AppBarCustomPainterShape extends CustomPainter {
  final Color color;

  AppBarCustomPainterShape(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.7563629);
    path_0.cubicTo(size.width * 0.6950531, size.height * 1.077114,
        size.width * 0.1854068, size.height, 0, size.height * 0.7563629);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.7563629);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
