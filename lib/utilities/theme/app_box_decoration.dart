import 'package:flutter/material.dart';
import 'package:ipotec/utilities/theme/core_box_shadow.dart';
import 'package:ipotec/utilities/theme/smooth_rectangular_border.dart';

class AppBoxDecoration {
  static BoxDecoration getBoxDecoration({
    double borderRadius = 10,
    Color color = Colors.white,
    double spreadRadius = 0,
    double blurRadius = 20,
    bool showShadow = true,
    BoxBorder? border,
  }) {
    return BoxDecoration(
      borderRadius: SmoothBorderRadius(
        cornerRadius: borderRadius,
        cornerSmoothing: 1.0,
      ),
      border: border,
      color: color,
      boxShadow: showShadow == true
          ? AppBoxShadow.legacyShadow
          // ? [
          //     BoxShadow(
          //       spreadRadius: spreadRadius,
          //       blurRadius: blurRadius,
          //       color: Colors.black.withOpacity(0.06),
          //       offset: const Offset(0, 4),
          //     ),
          //   ]
          : [],
    );
  }
}
