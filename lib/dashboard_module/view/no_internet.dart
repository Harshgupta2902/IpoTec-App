import 'package:flutter/material.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Center(
                child: Lottie.asset(AssetPath.noInternet),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
