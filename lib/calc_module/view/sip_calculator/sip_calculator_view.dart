import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/sip_calculator_controller.dart';
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

final _sipCalculatorController = Get.put(SIPCalculatorController());

class SipCalculatorView extends StatefulWidget {
  const SipCalculatorView({super.key});

  @override
  State<SipCalculatorView> createState() => _SipCalculatorViewState();
}

class _SipCalculatorViewState extends State<SipCalculatorView> {
  final TextEditingController _invTextController = TextEditingController();
  final TextEditingController _returnsTextController = TextEditingController();
  final TextEditingController _tenureTextController = TextEditingController();
  bool? isLoading;
  double invValue = 25000;
  double retValue = 12;
  double tenureValue = 10;

  final _sipCalcFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _invTextController.text = '25000';
    _returnsTextController.text = '12';
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
          title: "SIP Calculator",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _sipCalcFormKey,
            child: Column(
              children: [
                // monthly Investmemnts
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _invTextController,
                  hintText: "Monthly Investment",
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
                          _invTextController.text = '25000';
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
                          if (_sipCalcFormKey.currentState?.validate() ?? false) {
                            setState(() {
                              isLoading = true;
                            });
                            await _sipCalculatorController.calculateSIP(
                              sipAmount: double.tryParse(_invTextController.text) ?? 0,
                              returnRate: double.tryParse(_returnsTextController.text) ?? 0,
                              tenure: int.parse(_tenureTextController.text),
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
                      : _sipCalculatorController.obx(
                          (state) {
                            final estRet = format2INR(
                                ((state?.reports.yearlyReport.last.value ?? 0) -
                                    (state?.totalInvestAmount ?? 0)));

                            List<KeyValuePairModel> keyValueList = [
                              KeyValuePairModel(
                                key: "Maturity Amount: ",
                                value: format2INR((state?.sipAmount ?? 0) +
                                    (state?.reports.yearlyReport.last.value ?? 0)),
                                extra:
                                    " (${state?.reports.yearlyReport.last.currencyGainLossPer.toStringAsFixed(2)}%)",
                              ),
                              KeyValuePairModel(
                                key: "Invested Amount",
                                value: format2INR(state?.totalInvestAmount ?? 0),
                              ),
                              KeyValuePairModel(
                                key: "Est. Returns",
                                value: estRet,
                              ),
                            ];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    MyNavigator.pushNamed(GoPaths.sipCalculatorResult);
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
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ListView.separated(
                                          itemCount: keyValueList.length,
                                          padding: EdgeInsets.only(top: 16),
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final data = keyValueList[index];
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
                                const SizedBox(height: kToolbarHeight),
                                SizedBox(
                                  height: 180,
                                  child: BarChart(
                                    BarChartData(
                                      gridData: const FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                      titlesData: FlTitlesData(
                                        leftTitles: const AxisTitles(),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              String legend = "Invested";
                                              if (value == 1) {
                                                legend = "Returns";
                                              }
                                              if (value == 2) {
                                                legend = "Final Value";
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 4),
                                                child: Text(legend,
                                                    style: Theme.of(context).textTheme.titleSmall),
                                              );
                                            },
                                          ),
                                        ),
                                        topTitles: const AxisTitles(),
                                        rightTitles: const AxisTitles(),
                                      ),
                                      barTouchData: BarTouchData(
                                        touchTooltipData: BarTouchTooltipData(
                                          tooltipRoundedRadius: 8,
                                          tooltipPadding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          tooltipMargin: 10,
                                          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                            return BarTooltipItem(
                                              compactFormat2INR(rod.toY),
                                              const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                          getTooltipColor: (group) {
                                            if (group.x == 0) {
                                              return Colors.blue;
                                            } else if (group.x == 1) {
                                              return Colors.green;
                                            } else {
                                              return Colors.orange;
                                            }
                                          },
                                          fitInsideHorizontally: true,
                                        ),
                                      ),
                                      barGroups: [
                                        BarChartGroupData(
                                          x: 0,
                                          barsSpace: 80,
                                          showingTooltipIndicators: [0],
                                          barRods: [
                                            BarChartRodData(
                                              toY: state?.totalInvestAmount ?? 0,
                                              color: AppColors.primaryColor,
                                              width: 40,
                                              borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 1,
                                          barsSpace: 80,
                                          showingTooltipIndicators: [0],
                                          barRods: [
                                            BarChartRodData(
                                              toY: state?.totalReturns ?? 0,
                                              color: AppColors.shareGreen,
                                              width: 40,
                                              borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        BarChartGroupData(
                                          x: 2,
                                          barsSpace: 80,
                                          showingTooltipIndicators: [0],
                                          barRods: [
                                            BarChartRodData(
                                              toY: ((state?.sipAmount ?? 0) +
                                                  (state?.reports.yearlyReport.last.value ?? 0)),
                                              color: AppColors.mediumGreen,
                                              width: 40,
                                              borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
