import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/ipo_module/controller/drawer/ipo_performance_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:ipotec/ipo_module/modal/drawer/ipo_performance_model.dart';

final _performanceController = Get.put(IpoPerformanceController());

class IpoPerformanceView extends StatefulWidget {
  const IpoPerformanceView({super.key});

  @override
  State<IpoPerformanceView> createState() => _IpoPerformanceViewState();
}

class _IpoPerformanceViewState extends State<IpoPerformanceView> {
  final Map<int, bool> _expandedRows = {};

  @override
  void initState() {
    super.initState();
    _performanceController.getPerformance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CoreAppBar(
        title: "Ipo Performance",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _performanceController.obx((state) {
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
                      _buildTableCell("Company Name", isHeader: true, color: AppColors.black),
                      _buildTableCell("Profit/Loss", isHeader: true, color: AppColors.black),
                      _buildTableCell("List Day Gain", isHeader: true, color: AppColors.black),
                      _buildTableCell("", isHeader: true),
                    ],
                  ),
                ],
              ),
              ...List.generate(
                state?.data?.length ?? 0,
                (index) => _buildExpandableRow(index, state?.data?[index]),
              ),
            ],
          ),
        );
      }),
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

  Widget _buildExpandableRow(int index, Data? details) {
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
                GestureDetector(
                    onTap: () {
                      MyNavigator.pushNamed(
                        GoPaths.ipoDetails,
                        extra: {
                          'slug': details?.href,
                          'name': details?.companyName,
                        },
                      );
                    },
                    child: _buildTableCell(
                      details?.companyName ?? "",
                      underline: true,
                    )),
                _buildTableCell(
                  details?.profitLoss ?? "",
                  color: getPercentageColor(details?.profitLoss ?? ""),
                ),
                _buildTableCell(
                  details?.changePercentageListingDay ?? "",
                  color: getPercentageColor(details?.changePercentageListingDay ?? ""),
                ),
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

  Widget _buildDetailCell(Data? details) {
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
                  _buildTableCell("Current Price"),
                  _buildTableCell(
                    details?.bseClose ?? "",
                    color: getPriceComparisonColor(
                      details?.bseClose ?? "",
                      details?.issuePrice ?? "",
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Issue Price"),
                  _buildTableCell(details?.issuePrice ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Listing Day Close"),
                  _buildTableCell(
                    details?.closePrice ?? "",
                    color: getPriceComparisonColor(
                      details?.closePrice ?? "",
                      details?.issuePrice ?? "",
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Listed On"),
                  _buildTableCell(details?.listingDate ?? ""),
                ],
              ),
            ],
          ),
          CachedImageNetworkContainer(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
            height: 240,
            url:
                "https://main.icharts.in/ShowChart.php?symbol=${details?.nseScriptSymbol}&period=Daily&chart_type=LINE",
            placeHolder: buildNetworkPlaceholder(),
          ),
        ],
      ),
    );
  }
}
