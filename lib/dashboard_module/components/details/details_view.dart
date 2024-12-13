import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key, this.ipoDetails, this.promoterHolding, this.financialData});
  final List<IpoDetails>? ipoDetails;
  final List<PromoterHolding>? promoterHolding;
  final List<FinancialData>? financialData;
  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ipo Details",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          ...List.generate(widget.ipoDetails?.length ?? 0, (index) {
            return Table(
              border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(4),
              },
              children: [
                TableRow(
                  children: [
                    _buildTableCell(widget.ipoDetails?[index].key ?? ""),
                    _buildTableCell(widget.ipoDetails?[index].value ?? ""),
                  ],
                ),
              ],
            );
          }),
          const SizedBox(height: 22),
          Text(
            "Promoter Holdings",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          ...List.generate(widget.promoterHolding?.length ?? 0, (index) {
            return Table(
              border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(4),
              },
              children: [
                TableRow(
                  children: [
                    _buildTableCell(widget.promoterHolding?[index].key ?? ""),
                    _buildTableCell(widget.promoterHolding?[index].value ?? ""),
                  ],
                ),
              ],
            );
          }),

          const SizedBox(height: 22),


          Text(
            "Financial Data",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          ...List.generate(widget.promoterHolding?.length ?? 0, (index) {
            return Table(
              border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(4),
              },
              children: [
                TableRow(
                  children: [
                    _buildTableCell(widget.promoterHolding?[index].key ?? ""),
                    _buildTableCell(widget.promoterHolding?[index].value ?? ""),
                  ],
                ),
              ],
            );
          }),

        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color ?? Colors.blue.shade900,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w700,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
