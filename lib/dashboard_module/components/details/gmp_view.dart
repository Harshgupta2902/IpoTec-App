import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class GmpView extends StatefulWidget {
  const GmpView({super.key, this.gmpData});
  final List<GmpData>? gmpData;

  @override
  State<GmpView> createState() => _GmpViewState();
}

class _GmpViewState extends State<GmpView> {
  final Map<int, bool> _expandedRows = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  _buildTableCell("Date", isHeader: true, color: AppColors.black),
                  _buildTableCell("Price", isHeader: true, color: AppColors.black),
                  _buildTableCell("GMP", isHeader: true, color: AppColors.black),
                  _buildTableCell("", isHeader: true),
                ],
              ),
            ],
          ),
          ...List.generate(
            widget.gmpData?.length ?? 0,
            (index) => _buildExpandableRow(index, widget.gmpData?[index]),
          ),
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

  Widget _buildExpandableRow(int index, GmpData? details) {
    final isExpanded = _expandedRows[index] ?? false;
    return Column(
      children: [
        Table(
          border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                _buildTableCell(details?.gmpDate ?? ""),
                _buildTableCell(details?.ipoPrice ?? ""),
                _buildTableCell(details?.gmp ?? "",
                    color: details?.status == "up"
                        ? AppColors.shareGreen
                        : details?.status == "down"
                            ? AppColors.cadmiumRed
                            : Colors.blue.shade900),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expandedRows[index] = !isExpanded;
                    });
                  },
                  child: Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isExpanded)
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  _buildDetailCell(details),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildDetailCell(GmpData? details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "More Information",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.shuttleGrey,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                children: [
                  _buildTableCell("Sub2 Sauda Rate"),
                  _buildTableCell(
                    details?.sub2Sauda ?? "",
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Estimated Listing Price	"),
                  _buildTableCell(details?.estimatedListingPrice ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Last Updated"),
                  _buildTableCell(
                    details?.lastUpdated ?? "",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
