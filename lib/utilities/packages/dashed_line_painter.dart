import 'package:flutter/material.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class VerticalDashedLinePainter extends CustomPainter {
  final Color? color;
  VerticalDashedLinePainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 4, dashSpace = 2, startY = 0;
    final paint = Paint()
      ..color = color ?? AppColors.silverChalice30
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HorizontalDashedLinePainter extends CustomPainter {
  HorizontalDashedLinePainter({this.color, this.strokeWidth = 1});

  final Color? color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 4, dashSpace = 2, startX = 0;
    final paint = Paint()
      ..color =
          color ?? AppColors.silverChalice30 // You may want to use Colors instead of AppColors
      ..strokeWidth = strokeWidth;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
