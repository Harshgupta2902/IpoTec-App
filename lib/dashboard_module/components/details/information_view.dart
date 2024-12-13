import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key, this.address, this.registrar, required this.docs});

  final Address? address;
  final Registrar? registrar;
  final List<DocLinks>? docs;

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Address",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(4),
            },
            children: [
              TableRow(
                children: [
                  _buildTableCell("Name"),
                  _buildTableCell(widget.address?.name ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Address"),
                  _buildTableCell(widget.address?.address ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Phone"),
                  _buildTableCell(widget.address?.phone ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Email"),
                  _buildTableCell(widget.address?.email ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Website"),
                  _buildTableCell(widget.address?.website ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Name"),
                  _buildTableCell(widget.address?.name ?? ""),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            "Registrar Details",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Table(
            border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(4),
            },
            children: [
              TableRow(
                children: [
                  _buildTableCell("Name"),
                  _buildTableCell(widget.registrar?.name ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Phone"),
                  _buildTableCell(widget.registrar?.phone ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Email"),
                  _buildTableCell(widget.registrar?.email ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Website"),
                  _buildTableCell(widget.registrar?.website ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Name"),
                  _buildTableCell(widget.address?.name ?? ""),
                ],
              ),
            ],
          ),

          // Links
          const SizedBox(height: 22),
          Text(
            "Docs",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Table(
              border: TableBorder.all(color: AppColors.silverChalice30, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(4),
                1: FlexColumnWidth(2),
              },
              children: List.generate(widget.docs?.length ?? 0, (index) {
                return TableRow(
                  children: [
                    _buildTableCell(widget.docs?[index].name ?? ""),
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(
                          GoPaths.webView,
                          extra: {
                            'url': widget.docs?[index].link,
                            'title': widget.docs?[index].name,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.shuttleGrey,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              }))
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
