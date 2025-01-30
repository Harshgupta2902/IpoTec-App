import 'package:flutter/material.dart';
import 'package:ipotec/calc_module/modal/core_calculator_invest_value_model.dart';
import 'package:ipotec/calc_module/view/sip_calculator/sip_calculator_result.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class CoreCalculatorReportView extends StatefulWidget {
  const CoreCalculatorReportView({
    super.key,
    required this.monthlyReportWidget,
    required this.yearlyReportWidget,
  });

  final Widget monthlyReportWidget;
  final Widget yearlyReportWidget;

  @override
  State<CoreCalculatorReportView> createState() => _CoreCalculatorReportViewState();
}

class _CoreCalculatorReportViewState extends State<CoreCalculatorReportView> {
  bool isYearlyReport = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isYearlyReport = !isYearlyReport;
                  });
                },
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: 90 * (3.14159 / 180),
                      child: const Icon(
                        Icons.unfold_more,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      "${isYearlyReport ? " Yearly" : " Monthly"} Report",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (isYearlyReport) widget.yearlyReportWidget else widget.monthlyReportWidget
      ],
    );
  }
}

class ExpandableList extends StatefulWidget {
  const ExpandableList({
    super.key,
    required this.items,
    this.title,
  });

  final List<Widget> items;
  final List<String>? title;

  @override
  State<ExpandableList> createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.items.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (_selectedIndex == index) {
                _selectedIndex = -1;
                return;
              }
              _selectedIndex = index;
            });
          },
          child: Container(
            decoration: AppBoxDecoration.getBoxDecoration(),
            margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title?[index] ?? "Year ${index + 1}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AnimatedRotation(
                      turns: _selectedIndex == index ? 0.5 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  firstChild: widget.items[index],
                  secondChild: Container(),
                  crossFadeState: _selectedIndex == index
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

typedef IndexedRowBuilder = List<Widget> Function(
    BuildContext context, int index, CoreCalculatorInvestValueModel investValueModel);

class CoreCalculatorMonthlyReport extends StatefulWidget {
  const CoreCalculatorMonthlyReport({
    super.key,
    required this.itemCount,
    required this.columns,
    required this.report,
  });

  final int itemCount;
  final List<String> columns;
  final List<CoreCalculatorInvestValueModel> report;

  @override
  State<CoreCalculatorMonthlyReport> createState() => _CoreCalculatorMonthlyReportState();
}

class _CoreCalculatorMonthlyReportState extends State<CoreCalculatorMonthlyReport> {
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

class CoreCalculatorMonthlyReportwithItemBuilder extends StatefulWidget {
  const CoreCalculatorMonthlyReportwithItemBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.columns,
    required this.report,
  });

  final IndexedRowBuilder itemBuilder;
  final int itemCount;
  final List<String> columns;
  final List<CoreCalculatorInvestValueModel> report;

  @override
  State<CoreCalculatorMonthlyReportwithItemBuilder> createState() =>
      _CoreCalculatorMonthlyReportwithItemBuilderState();
}

class _CoreCalculatorMonthlyReportwithItemBuilderState
    extends State<CoreCalculatorMonthlyReportwithItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        columns: List.generate(widget.columns.length, (index) {
          return DataColumn(
            label: Text(widget.columns[index]),
          );
        }),
        rows: List.generate(widget.itemCount, (index) {
          final item = widget.itemBuilder(context, index, widget.report[index]);
          return DataRow(
            cells: List.generate(item.length, (index) {
              return DataCell(item[index]);
            }),
          );
        }),
      ),
    );
  }

}
