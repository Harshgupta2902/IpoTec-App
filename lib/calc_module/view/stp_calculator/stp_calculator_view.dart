import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/stp_calculator_controller.dart';
import 'package:flutter/services.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_text_form_fields.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

final _stpCalculatorController = Get.put(STPCalculatorController());

class StpCalculatorView extends StatefulWidget {
  const StpCalculatorView({super.key});

  @override
  State<StpCalculatorView> createState() => _StpCalculatorViewState();
}

class _StpCalculatorViewState extends State<StpCalculatorView> {
  final TextEditingController _invTextController = TextEditingController();
  final TextEditingController _returnsLiquidTextController = TextEditingController();
  final TextEditingController _returnsEquityTextController = TextEditingController();
  final TextEditingController _tenureTextController = TextEditingController();
  final TextEditingController _stpTextController = TextEditingController();
  bool? isLoading;

  @override
  void initState() {
    super.initState();
    _invTextController.text = '300000';
    _stpTextController.text = "6607";
    _returnsLiquidTextController.text = '12';
    _returnsEquityTextController.text = '14';
    _tenureTextController.text = '5';
  }

  void calculateSTPAmount() {
    final tenure = int.parse(_tenureTextController.text);
    int totalMonths = tenure * 12;

    final stpAmount = calculateWithdrawalAmountOfAnnuityDue(
      double.tryParse(_invTextController.text) ?? 0,
      (double.tryParse(_returnsLiquidTextController.text) ?? 0) / 12 / 100,
      totalMonths,
    );

    _stpTextController.text = stpAmount.toStringAsFixed(0);
  }

  double calculateWithdrawalAmountOfAnnuityDue(
      double periodicPayment, double interestRate, int periods) {
    double withdrawalAmountDue = (periodicPayment * interestRate) /
        ((1 - pow(1 + interestRate, -periods)) * (1 + interestRate));
    return withdrawalAmountDue;
  }

  final _stpCalcFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CoreAppBar(
          showBackButton: true,
          centerTitle: false,
          title: "STP Calculator",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _stpCalcFormKey,
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
                  onChanged: (value) {
                    calculateSTPAmount();
                  },
                ),

                // STP AMount
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _stpTextController,
                  hintText: "STP Amount",
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

                // liquid returns
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _returnsLiquidTextController,
                  hintText: "Expected Growth in Liquid Funds",
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

                // est returns
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _returnsEquityTextController,
                  hintText: "Expected Growth in Equity Funds",
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
                          _invTextController.text = '300000';
                          _stpTextController.text = "6607";
                          _returnsLiquidTextController.text = '12';
                          _returnsEquityTextController.text = '14';
                          _tenureTextController.text = '5';
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
                          if (_stpCalcFormKey.currentState?.validate() ?? false) {
                            setState(() {
                              isLoading = true;
                            });

                            await _stpCalculatorController.calculateSTP(
                              investmentAmount: double.tryParse(_invTextController.text) ?? 0,
                              stpAmount: double.tryParse(_stpTextController.text) ?? 0,
                              tenure: int.parse(_tenureTextController.text),
                              liquidReturn: double.tryParse(_returnsLiquidTextController.text) ?? 0,
                              equityReturn: double.tryParse(_returnsEquityTextController.text) ?? 0,
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
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
                      : _stpCalculatorController.obx((state) {
                          List<KeyValuePairModel> keyValueList1 = [
                            KeyValuePairModel(
                              key: "STP Amount: ",
                              value: format2INR(state?.stpAmount),
                            ),
                            KeyValuePairModel(
                              key: "Equity Returns: ",
                              value: format2INR(state?.equityReturns),
                            ),
                            KeyValuePairModel(
                              key: "Liq. Fund Returns: ",
                              value: format2INR(state?.liquidReturns),
                            ),
                            KeyValuePairModel(
                              key: "Maturity Amount: ",
                              value: format2INR(state?.growthValue),
                              extra: " (${state?.gainLossPer.toStringAsFixed(2)}%)",
                            ),
                            KeyValuePairModel(
                              key: "Invested Amount",
                              value: format2INR(state?.initialAmount),
                            ),
                            KeyValuePairModel(
                              key: "Est. Returns",
                              value: format2INR(
                                  (state?.equityReturns ?? 0) + (state?.liquidReturns ?? 0)),
                            ),
                          ];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  MyNavigator.pushNamed(GoPaths.stpCalculatorResult);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AssetPath.imageCardBanner),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ListView.separated(
                                        itemCount: keyValueList1.length,
                                        padding: const EdgeInsets.only(top: 16),
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final data = keyValueList1[index];
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.key,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(fontWeight: FontWeight.w700),
                                              ),
                                              const SizedBox(height: 2),
                                              RichText(
                                                text: TextSpan(
                                                  text: data.value,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                  children: [
                                                    TextSpan(
                                                      text: data.extra,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(color: Colors.green),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            child: CustomPaint(
                                              size: Size(MediaQuery.of(context).size.width, 1),
                                              painter: HorizontalDashedLinePainter(
                                                  color: Colors.black54),
                                            ),
                                          );
                                        },
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
                              ),
                            ],
                          );
                        }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
