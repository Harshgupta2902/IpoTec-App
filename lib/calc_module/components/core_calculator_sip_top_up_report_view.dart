import 'package:flutter/material.dart';
import 'package:ipotec/calc_module/modal/core_calculator_invest_value_model.dart';
import 'package:ipotec/calc_module/view/sip_calculator/sip_calculator_result.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

typedef IndexedRowBuilder = List<Widget> Function(
    BuildContext context, int index, CoreCalculatorInvestValueModel investValueModel);

class CoreCalculatorSipTopUpMonthlyReport extends StatefulWidget {
  const CoreCalculatorSipTopUpMonthlyReport({
    super.key,
    required this.itemCount,
    required this.columns,
    required this.report,
  });

  final int itemCount;
  final List<String> columns;
  final List<CoreCalculatorInvestValueModel> report;

  @override
  State<CoreCalculatorSipTopUpMonthlyReport> createState() =>
      _CoreCalculatorSipTopUpMonthlyReportState();
}

class _CoreCalculatorSipTopUpMonthlyReportState extends State<CoreCalculatorSipTopUpMonthlyReport> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(1.3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                children: List.generate(widget.columns.length, (index) {
                  return _buildTableCell(
                    widget.columns[index],
                    isHeader: true,
                    color: AppColors.black,
                  );
                }),
              ),
            ],
          ),
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(1.3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: List.generate(widget.report.length, (index) {
              final reportItem = widget.report[index];
              return TableRow(
                children: [
                  _buildTableCell("${index + 1}"),
                  _buildTableCell(reportItem.currencyInvested),
                  _buildTableCell(reportItem.currencyValue),
                  AmountPercentageColor(
                    percentage: reportItem.currencyGainLossPer.toStringAsFixed(2),
                    amount: reportItem.currencyGainLoss.toString(),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text,
      {bool isHeader = false, Color? color, bool underline = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color ?? Colors.blue.shade900,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w700,
              decoration: underline ? TextDecoration.underline : null,
              decorationColor: underline ? AppColors.shuttleGrey : Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
