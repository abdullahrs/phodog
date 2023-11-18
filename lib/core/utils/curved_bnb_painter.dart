import 'package:flutter/rendering.dart';

class CurvedBNBShapePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double borderThickness;
  final double radiusMargin;

  CurvedBNBShapePainter({
    super.repaint,
    required this.fillColor,
    required this.borderColor,
    required this.borderThickness,
    this.radiusMargin = 40,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = fillColor; // Change color as needed

    Path path = Path();
    double w = size.width;
    double h = size.height;
    // Adjust the value of x for your desired curve radius
    double x = radiusMargin;

    // Drawing the custom shape
    path
      ..moveTo(x, 0)
      ..quadraticBezierTo(0, 0, 0, h)
      ..lineTo(w, h)
      ..quadraticBezierTo(w, 0, w - x, 0)
      ..lineTo(x, 0);

    // Drawing the border
    Paint borderPaint = Paint()
      ..color = borderColor // Change border color as needed
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness; // Change border width as needed

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
