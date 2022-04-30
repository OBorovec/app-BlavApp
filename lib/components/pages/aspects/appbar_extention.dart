import 'package:flutter/material.dart';

// TODO: make it a custom clipper
class AppBarExtention extends CustomPainter {
  final double _elevation;
  final BuildContext _context;

  AppBarExtention({
    double elevation = 0,
    required BuildContext context,
  })  : _elevation = elevation,
        _context = context;

  @override
  void paint(Canvas canvas, Size size) {
    // Working with defaulr color schemes
    // final Brightness brightness = Theme.of(_context).brightness;
    // final Color color = brightness == Brightness.light
    //     ? Theme.of(_context).primaryColor
    //     : Theme.of(_context).bottomAppBarColor;
    // Path path = _paintShape(color, canvas);
    // working for flex_color_scheme package
    Color color = Theme.of(_context).scaffoldBackgroundColor;
    Path path = _paintShape(color, canvas);
    Color color2 = Theme.of(_context).appBarTheme.backgroundColor!;
    _paintShape(color2, canvas);
    if (_elevation > 0) {
      canvas.drawShadow(path, Colors.black45, _elevation, true);
    }
  }

  Path _paintShape(Color color, Canvas canvas) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    // lines up with Radius.elliptical(40, 36)
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(40, 0)
      ..quadraticBezierTo(0, 0, 0, 20)
      ..close();
    canvas.drawPath(
      path,
      paint,
    );
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
