import 'package:flutter/material.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class CustomErrorOrEmpty extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;

  const CustomErrorOrEmpty({
    super.key,
    this.height,
    this.width,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          AssetPath.emptyLottie,
          height: 100,
          width: 100,
        ),
        Text(
          title ?? "No data Found",
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
