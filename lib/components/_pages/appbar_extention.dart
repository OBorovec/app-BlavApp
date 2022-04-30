import 'package:flutter/material.dart';

// TODO: make it a custom clipper
class AppBarExtention extends CustomPainter {
  final Color _color;
  final double _elevation;

  AppBarExtention({
    required Color color,
    double elevation = 0,
  })  : _color = color,
        _elevation = elevation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;
    // lines up with Radius.elliptical(40, 36)
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(48, 0)
      ..quadraticBezierTo(0, 0, 0, 40)
      ..close();
    canvas.drawPath(
      path,
      paint,
    );
    if (_elevation > 0) {
      canvas.drawShadow(path, Colors.black45, _elevation, true);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
