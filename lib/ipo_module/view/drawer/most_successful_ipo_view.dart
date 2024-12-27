import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/ipo_module/controller/drawer/most_successful_ipo_controller.dart';
import 'package:ipotec/ipo_module/modal/drawer/most_successful_ipo_model.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _mostSuccessfulIpoController = Get.put(MostSuccessfulIpoController());

class MostSuccessfulIpoView extends StatefulWidget {
  const MostSuccessfulIpoView({super.key});

  @override
  State<MostSuccessfulIpoView> createState() => _MostSuccessfulIpoViewState();
}

class _MostSuccessfulIpoViewState extends State<MostSuccessfulIpoView> {
  final Map<int, bool> _expandedRows = {};

  @override
  void initState() {
    super.initState();
    _mostSuccessfulIpoController.getMostSuccessfulIpo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CoreAppBar(
        title: "Most Successful Ipo",
        showBackButton: true,
        centerTitle: false,
      ),
      body: _mostSuccessfulIpoController.obx((state) {
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
                      GestureDetector(
                        onTap: () {
                          _mostSuccessfulIpoController.sortByListingGain();
                          setState(() {});
                        },
                        child: _buildTableCell(
                          "Listing Gain",
                          isHeader: true,
                          color: AppColors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _mostSuccessfulIpoController.sortByCurrentGain();
                          setState(() {});
                        },
                        child: _buildTableCell(
                          "Current Gain",
                          isHeader: true,
                          color: AppColors.black,
                        ),
                      ),
                      _buildTableCell("", isHeader: true),
                    ],
                  ),
                ],
              ),
              ...List.generate(
                state?.body?.length ?? 0,
                (index) => _buildExpandableRow(index, state?.body?[index]),
              ),
            ],
          ),
        );
      }),
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

  Widget _buildExpandableRow(int index, Body? details) {
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
                _buildTableCell(details?.companyName ?? ""),
                _buildTableCell(
                  "${details?.listingGainP}%",
                  color: getPercentageColor(details?.listingGainP?.toString() ?? ""),
                ),
                _buildTableCell(
                  "${details?.currentGainP}%",
                  color: getPercentageColor(details?.currentGainP?.toString() ?? ""),
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

  Widget _buildDetailCell(Body? details) {
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
                    details?.currentPrice?.toString() ?? "",
                    color: getPriceComparisonColor(
                      details?.issuePrice?.toString() ?? "",
                      details?.currentPrice?.toString() ?? "",
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Issue Price"),
                  _buildTableCell(details?.issuePrice?.toString() ?? ""),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Listing Day Open"),
                  _buildTableCell(
                    details?.listingOpenPrice?.toString() ?? "",
                    color: getPriceComparisonColor(
                      details?.issuePrice?.toString() ?? "",
                      details?.listingOpenPrice?.toString() ?? "",
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Listing Day Close"),
                  _buildTableCell(
                    details?.listingClosePrice?.toString() ?? "",
                    color: getPriceComparisonColor(
                      details?.issuePrice?.toString() ?? "",
                      details?.listingClosePrice?.toString() ?? "",
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Issue Size"),
                  _buildTableCell(
                    details?.issueSize?.toString() ?? "",
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Total Subscription "),
                  _buildTableCell(
                    details?.totalSubscription?.toString() ?? "",
                    color: AppColors.shareGreen,
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell("Market Cap (in Cr.)"),
                  _buildTableCell(
                    details?.mcapQ?.toString() ?? "",
                    color: AppColors.shareGreen,
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
