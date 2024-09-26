import 'package:flutter/material.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class AppBoxShadow {
  static List<BoxShadow> legacyShadow = [
    const BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 10,
      color: AppColors.black04,
    )
  ];

  static List<BoxShadow> calculatorShadow = const [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 10,
      color: AppColors.black04,
    )
  ];
}
