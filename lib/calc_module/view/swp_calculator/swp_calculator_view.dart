import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/swp_calculator_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_text_form_fields.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

final _swpCalculatorController = Get.put(SWPCalculatorController());

class SwpCalculatorView extends StatefulWidget {
  const SwpCalculatorView({super.key});

  @override
  State<SwpCalculatorView> createState() => _SwpCalculatorViewState();
}

class _SwpCalculatorViewState extends State<SwpCalculatorView> {
  final TextEditingController _invTextController = TextEditingController();
  final TextEditingController _withdrawTextController = TextEditingController();
  final TextEditingController _returnsTextController = TextEditingController();
  final TextEditingController _tenureTextController = TextEditingController();
  bool? isLoading;
  double invValue = 25000;
  double retValue = 12;
  double tenureValue = 10;

  @override
  void initState() {
    super.initState();
    _invTextController.text = '5000000';
    _withdrawTextController.text = "50000";
    _returnsTextController.text = '8';
    _tenureTextController.text = '10';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CoreAppBar(
          showBackButton: true,
          centerTitle: false,
          title: "SWP Calculator",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              // monthly Investmemnts
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _invTextController,
                hintText: "Total Investment",
                keyboardType: TextInputType.number,
                inputFormatter: [
                  LengthLimitingTextInputFormatter(7),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validationMode: AutovalidateMode.onUserInteraction,
                validator: (invValue) {
                  if (invValue == "" || invValue == null) {
                    return "Please enter amount";
                  } else if (invValue == '0') {
                    return "Please enter valid amount";
                  } else {
                    return null;
                  }
                },
              ),

              // Withdraw per month
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _withdrawTextController,
                hintText: "Withdraw Per Month",
                keyboardType: TextInputType.number,
                inputFormatter: [
                  LengthLimitingTextInputFormatter(7),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validationMode: AutovalidateMode.onUserInteraction,
                validator: (invValue) {
                  if (invValue == "" || invValue == null) {
                    return "Please enter amount";
                  } else if (invValue == '0') {
                    return "Please enter valid amount";
                  } else {
                    return null;
                  }
                },
              ),

              // Tenure
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _tenureTextController,
                hintText: "Tenure (in Years)",
                keyboardType: TextInputType.number,
                inputFormatter: [
                  LengthLimitingTextInputFormatter(2),
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                ],
                validationMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Please enter year";
                  } else if (double.tryParse(value) == null ||
                      double.parse(value) < 1 ||
                      double.parse(value) > 40) {
                    return "Please enter year between 1 and 40";
                  } else {
                    return null;
                  }
                },
              ),

              // est returns
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _returnsTextController,
                hintText: "Expected Returns on Balance",
                keyboardType: TextInputType.number,
                inputFormatter: [
                  LengthLimitingTextInputFormatter(5),
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                ],
                validationMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Please enter a valid percentage";
                  } else if (double.tryParse(value) == null ||
                      double.parse(value) < 1 ||
                      double.parse(value) > 30) {
                    return "Please enter a percentage between 1 and 30";
                  } else {
                    return null;
                  }
                },
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        _invTextController.text = '5000000';
                        _withdrawTextController.text = "50000";
                        _returnsTextController.text = '8';
                        _tenureTextController.text = '10';
                        setState(() {
                          isLoading = null;
                        });
                      },
                      child: const Text("Reset"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _swpCalculatorController.calculateSWP(
                          corpusAmount: double.tryParse(_invTextController.text) ?? 0,
                          returnRate: double.tryParse(_returnsTextController.text) ?? 0,
                          pensionAmount: double.tryParse(_withdrawTextController.text) ?? 0,
                          timePeriodInYears: int.parse(_tenureTextController.text),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text("Calculate"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: kToolbarHeight - 20),
              if (isLoading != null) ...[
                isLoading == true
                    ? Lottie.asset(AssetPath.loaderLottie)
                    : _swpCalculatorController.obx((state) {
                        return GestureDetector(
                          onTap: () {
                            MyNavigator.pushNamed(GoPaths.swpCalculatorResult);
                          },
                          child: Container(
                            decoration: AppBoxDecoration.getBoxDecoration(),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: RichText(
                                            text: TextSpan(
                                              text: "Final Value\n",
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              children: [
                                                TextSpan(
                                                  text: format2INR((state?.withdrawnAmount ?? 0) +
                                                      (state?.reports.yearlyReport.last.value ??
                                                          0)),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge
                                                      ?.copyWith(fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(bottom: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.trending_up,
                                                color: Colors.green,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${state?.gainLossPer.toStringAsFixed(2)}%",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(color: Colors.green),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Invested Amount",
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              format2INR(state?.corpusAmount),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Returns Earned",
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              format2INR(state?.interestEarned),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: Transform.rotate(
                                    angle: 315 * (3.14159 / 180),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
