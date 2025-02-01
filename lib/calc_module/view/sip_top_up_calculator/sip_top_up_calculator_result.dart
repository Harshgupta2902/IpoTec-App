import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/components/core_calculator_sip_top_up_report_view.dart';
import 'package:ipotec/calc_module/controller/step_up_sip_calculator.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _stepUpSIPController = Get.put(StepUpSIPController());

class SipTopUpCalculatorResult extends StatefulWidget {
  const SipTopUpCalculatorResult({super.key});

  @override
  State<SipTopUpCalculatorResult> createState() => _SipTopUpCalculatorResultState();
}

class _SipTopUpCalculatorResultState extends State<SipTopUpCalculatorResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CoreAppBar(
        title: "SIP Top Up Result",
        centerTitle: false,
        showBorder: true,
      ),
      body: _stepUpSIPController.obx((state) {
        return SingleChildScrollView(
          child: CoreCalculatorReportView(
            monthlyReportWidget: ExpandableList(
              items: List.generate(state?.topUpReports.monthlyReport.length ?? 0, (index) {
                final monthlyReport = state?.topUpReports.monthlyReport[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CoreCalculatorSipTopUpMonthlyReport(
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
              child: CoreCalculatorSipTopUpMonthlyReport(
                report: state?.topUpReports.yearlyReport ?? [],
                itemCount: state?.topUpReports.yearlyReport.length ?? 0,
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
