import 'package:flutter/material.dart';
import 'package:ipotec/ipo_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key, this.subscriptionData});
  final List<SubscriptionData>? subscriptionData;

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(2.4),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                children: [
                  _buildTableCell("Investor Category", isHeader: true, color: AppColors.black),
                  _buildTableCell("Subs (times)", isHeader: true, color: AppColors.black),
                  _buildTableCell("Shares offered", isHeader: true, color: AppColors.black),
                  _buildTableCell("Shares bid for", isHeader: true, color: AppColors.black),
                  _buildTableCell("Total Amount", isHeader: true, color: AppColors.black),
                ],
              )
            ],
          ),
          Table(
              border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2.4),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(2),
              },
              children: List.generate(widget.subscriptionData?.length ?? 0, (index) {
                final subs = widget.subscriptionData?[index];
                return TableRow(
                  children: [
                    _buildTableCell(subs?.investorCategory ?? ""),
                    _buildTableCell(subs?.subscriptionTimes ?? ""),
                    _buildTableCell(subs?.sharesOffered ?? ""),
                    _buildTableCell(subs?.sharesBidFor ?? ""),
                    _buildTableCell(subs?.totalAmount ?? ""),
                  ],
                );
              })),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: isHeader
            ? Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color ?? Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                )
            : Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color ?? Colors.blue.shade900,
                  fontWeight: FontWeight.w700,
                ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
