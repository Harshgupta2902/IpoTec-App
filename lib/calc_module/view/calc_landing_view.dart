import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/auth_controller.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _authController = Get.put(AuthController());

class CalcLandingView extends StatefulWidget {
  const CalcLandingView({super.key});

  @override
  State<CalcLandingView> createState() => _CalcLandingViewState();
}

class _CalcLandingViewState extends State<CalcLandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(top: 40, bottom: 10, left: 12, right: 12),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetPath.blueBg),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Finance Calculator",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Take Control of your Finances".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Know your EMI Instantly, Plan your Finances Wisely & Compare Loan Options",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.white,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      AssetPath.calcIconPng,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: GestureDetector(
              onTap: () {
                MyNavigator.pushNamed(GoPaths.lumpSumCalculatorView);
              },
              child: Image.asset(AssetPath.lumpCalc),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(GoPaths.sipCalculatorView);
                      },
                      child: Image.asset(
                        AssetPath.sipCalc,
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.height * 0.22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(GoPaths.sipTopupCalculatorView);
                      },
                      child: Image.asset(
                        AssetPath.sipTopUpCalc,
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width / 2.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(GoPaths.stpCalculatorView);
                      },
                      child: Image.asset(
                        AssetPath.stpCalc,
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width / 2.3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(GoPaths.swpCalculatorView);
                      },
                      child: Image.asset(
                        AssetPath.swpCalc,
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width / 2.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(GoPaths.sipPlanCalculatorView);
                      },
                      child: Image.asset(
                        AssetPath.sipPlanCalc,
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width / 2.3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
