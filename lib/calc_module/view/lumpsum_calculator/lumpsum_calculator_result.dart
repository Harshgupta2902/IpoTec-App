import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/controller/lumpsum_calculator_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _lumpSumCalculatorController = Get.put(LumpsumCalculatorController());

class LumpsumCalculatorResult extends StatefulWidget {
  const LumpsumCalculatorResult({super.key});

  @override
  State<LumpsumCalculatorResult> createState() => _LumpsumCalculatorResultState();
}

class _LumpsumCalculatorResultState extends State<LumpsumCalculatorResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CoreAppBar(
        title: "Lumpsum Calculator Result",
        centerTitle: false,
        showBorder: true,
      ),
      body: _lumpSumCalculatorController.obx((state) {
        return SingleChildScrollView(
          child: CoreCalculatorReportView(
            monthlyReportWidget: ExpandableList(
              items: List.generate(state?.reports.monthlyReport.length ?? 0, (index) {
                final monthlyReport = state?.reports.monthlyReport[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CoreCalculatorMonthlyReport(
                    report: monthlyReport ?? [],
                    itemCount: monthlyReport?.length ?? 0,
                    columns: const [
                      "Month",
                      "Invested",
                      "Value",
                      "Return",
                    ],
                  ),
                );
              }),
            ),
            yearlyReportWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              child: CoreCalculatorMonthlyReport(
                report: state?.reports.yearlyReport ?? [],
                itemCount: state?.reports.yearlyReport.length ?? 0,
                columns: const [
                  "Year",
                  "Invested",
                  "Value",
                  "Return",
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AmountPercentageColor extends StatelessWidget {
  final String percentage;
  final String amount;
  final double? amountFontSize;
  final double? percentageFontSize;

  const AmountPercentageColor({
    super.key,
    required this.percentage,
    required this.amount,
    this.amountFontSize = 14,
    this.percentageFontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final number = num.tryParse(percentage);

    final isPositive = number != null && number < 0 ? false : true;
    final color = isPositive ? AppColors.mediumGreen : AppColors.cadmiumRed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
          text: amount,
          children: <TextSpan>[
            TextSpan(
              text: ' ($percentage%)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
