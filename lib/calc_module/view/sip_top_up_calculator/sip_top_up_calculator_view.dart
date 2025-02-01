import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/step_up_sip_calculator.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_text_form_fields.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

final _stepUpSIPController = Get.put(StepUpSIPController());

class SipTopUpCalculator extends StatefulWidget {
  const SipTopUpCalculator({super.key});

  @override
  State<SipTopUpCalculator> createState() => _SipTopUpCalculatorState();
}

class _SipTopUpCalculatorState extends State<SipTopUpCalculator> {
  final TextEditingController _invTextController = TextEditingController();
  final TextEditingController _returnsTextController = TextEditingController();
  final TextEditingController _tenureTextController = TextEditingController();
  final TextEditingController _stepUpTextController = TextEditingController();
  bool? isLoading;
  double invValue = 25000;
  double retValue = 12;
  double tenureValue = 10;
  int _selectedStepUpType = 0;

  static List<KeyValuePairModel<int, String, void>> stepUp = [
    KeyValuePairModel(key: 0, value: 'Percentage'),
    KeyValuePairModel(key: 1, value: 'Amount'),
  ];

  final _sipTopUpCalcFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _invTextController.text = '10000';
    _returnsTextController.text = '12';
    _tenureTextController.text = '10';
    _stepUpTextController.text = '10';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CoreAppBar(
        showBackButton: true,
        centerTitle: false,
        title: "SIP Top Up Calculator",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _sipTopUpCalcFormKey,
          child: Column(
            children: [
              // Regular Deposit Amount
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _invTextController,
                hintText: "Regular Deposit Amount",
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

              // est returns
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _returnsTextController,
                hintText: "Expected Returns",
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

              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: _stepUpTextController,
                      hintText: "Step Up ${_selectedStepUpType == 0 ? "Percentage" : "Amount"}",
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(_selectedStepUpType == 0 ? 2 : 6),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validationMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a value";
                        }
                        final parsedValue = double.tryParse(value);
                        if (parsedValue == null) {
                          return "Invalid value entered";
                        }
                        if (_selectedStepUpType == 0) {
                          // Validation for Percentage
                          if (parsedValue < 1 || parsedValue > 20) {
                            return "Percentage must be between 1 and 20";
                          }
                        } else {
                          // Validation for Amount
                          if (parsedValue < 100 || parsedValue > 50000) {
                            return "Amount must be between 100 and 50,000";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  CoreCalculatorDropDownInput<int>(
                    value: _selectedStepUpType,
                    dropDownList: stepUp,
                    onChange: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedStepUpType = value;
                      });
                    },
                  )
                ],
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
                        _invTextController.text = '10000';
                        _returnsTextController.text = '12';
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
                        if (_sipTopUpCalcFormKey.currentState?.validate() ?? false) {
                          setState(() {
                            isLoading = true;
                          });
                          await _stepUpSIPController.calculateStepUP(
                            sipAmount: double.tryParse(_invTextController.text) ?? 0,
                            tenure: int.parse(_tenureTextController.text),
                            returnRate: double.tryParse(_returnsTextController.text) ?? 0,
                            stepUpPercentage: _selectedStepUpType == 0
                                ? double.tryParse(_stepUpTextController.text)
                                : null,
                            stepUpAmount: _selectedStepUpType == 1
                                ? double.tryParse(_stepUpTextController.text)
                                : null,
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
                    : _stepUpSIPController.obx(
                        (state) {
                          final report = state?.reports.yearlyReport.last;
                          final topUpReport = state?.topUpReports.yearlyReport.last;

                          List<KeyValuePairModel> keyValueList1 = [
                            KeyValuePairModel(
                              key: "Maturity Amount: ",
                              value: state?.topUpReports.yearlyReport.last.currencyValue,
                              extra:
                                  " (${state?.topUpReports.yearlyReport.last.currencyGainLossPer.toStringAsFixed(2)}%)",
                            ),
                            KeyValuePairModel(
                              key: "Invested Amount",
                              value: topUpReport?.currencyInvested,
                            ),
                            KeyValuePairModel(
                              key: "Est. Returns",
                              value: format2INR((state?.topUpReports.yearlyReport.last.value ?? 0) -
                                  (topUpReport?.invest ?? 0)),
                            ),
                          ];

                          List<KeyValuePairModel> keyValueList2 = [
                            KeyValuePairModel(
                              key: "Maturity Amount: ",
                              value: format2INR((state?.sipAmount ?? 0) +
                                  (state?.reports.yearlyReport.last.value ?? 0)),
                              extra:
                                  " (${state?.reports.yearlyReport.last.currencyGainLossPer.toStringAsFixed(2)}%)",
                            ),
                            KeyValuePairModel(
                              key: "Invested Amount",
                              value: report?.currencyInvested,
                            ),
                            KeyValuePairModel(
                              key: "Est. Returns",
                              value: format2INR((state?.topUpReports.yearlyReport.last.value ?? 0) -
                                  (topUpReport?.invest ?? 0)),
                            ),
                          ];

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  MyNavigator.pushNamed(GoPaths.sipTopupCalculatorResult);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AssetPath.imageCardBanner),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        "With StepUp",
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              decoration: TextDecoration.underline,
                                              color: AppColors.shareGreen,
                                            ),
                                      ),
                                      ListView.separated(
                                        itemCount: keyValueList1.length,
                                        padding: const EdgeInsets.only(top: 30),
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
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  MyNavigator.pushNamed(GoPaths.sipTopupCalculatorResult);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AssetPath.imageCardBanner),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        "Without StepUp",
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              decoration: TextDecoration.underline,
                                              color: AppColors.shareGreen,
                                            ),
                                      ),
                                      ListView.separated(
                                        itemCount: keyValueList2.length,
                                        padding: const EdgeInsets.only(top: 30),
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final data = keyValueList2[index];
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
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Comparison",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: AppColors.androidGreen,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Value with Step Up",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(color: AppColors.boulder),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: AppColors.primaryColor,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Value without Step Up",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(color: AppColors.boulder),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 240,
                                      child: LineChart(
                                        LineChartData(
                                          lineTouchData: LineTouchData(
                                            touchTooltipData: LineTouchTooltipData(
                                              getTooltipItems: (touchedSpots) {
                                                return [
                                                  LineTooltipItem(
                                                    'without top up ',
                                                    const TextStyle(
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: format2INR(touchedSpots[0].y),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  LineTooltipItem(
                                                    'with top up  ',
                                                    const TextStyle(
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: format2INR(touchedSpots[1].y),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ];
                                              },
                                            ),
                                          ),
                                          borderData: FlBorderData(show: false),
                                          titlesData: const FlTitlesData(
                                            leftTitles: AxisTitles(),
                                            topTitles: AxisTitles(),
                                            rightTitles: AxisTitles(),
                                          ),
                                          gridData: const FlGridData(show: false),
                                          lineBarsData: [
                                            LineChartBarData(
                                              color: AppColors.primaryColor,
                                              isCurved: true,
                                              spots: List.generate(
                                                state?.reports.yearlyReport.length ?? 0,
                                                (index) {
                                                  final report = state?.reports.yearlyReport[index];
                                                  return FlSpot(
                                                    index.toDouble() + 1,
                                                    report?.value ?? 0,
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                            LineChartBarData(
                                              color: AppColors.androidGreen,
                                              isStepLineChart: false,
                                              isCurved: true,
                                              spots: List.generate(
                                                state?.topUpReports.yearlyReport.length ?? 0,
                                                (index) {
                                                  final report =
                                                      state?.topUpReports.yearlyReport[index];
                                                  return FlSpot(
                                                    index.toDouble() + 1,
                                                    report?.value ?? 0,
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Year",
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CoreCalculatorDropDownInput<T> extends StatelessWidget {
  const CoreCalculatorDropDownInput({
    super.key,
    required this.onChange,
    required this.dropDownList,
    required this.value,
  });

  final List<KeyValuePairModel<T, String, void>> dropDownList;
  final Function(T? value) onChange;
  final T value;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          isDense: true,
          padding: const EdgeInsets.only(top: 20),
          onChanged: onChange,
          items: List.generate(
            dropDownList.length,
            (index) {
              final keyValueItem = dropDownList[index];
              return DropdownMenuItem<T>(
                value: keyValueItem.key,
                child: Text(
                  keyValueItem.value,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
