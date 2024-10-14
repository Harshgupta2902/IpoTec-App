import 'package:flutter/material.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class TryAgainWidget extends StatefulWidget {
  const TryAgainWidget({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  State<TryAgainWidget> createState() => _TryAgainWidgetState();
}

class _TryAgainWidgetState extends State<TryAgainWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          AssetPath.tryAgain,
          height: 256,
          width: 256,
        ),
        GestureDetector(
          onTap: widget.onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Try Again!",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Icon(
                Icons.replay,
                size: 22,
                color: AppColors.primaryColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
