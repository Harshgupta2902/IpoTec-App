import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/ipo_module/components/mainboard_upcoming_card.dart';
import 'package:ipotec/ipo_module/controller/bottom/sme_ipo_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_error_or_empty.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _smeIpoController = Get.put(SmeIpoController());

class SmeIpoView extends StatefulWidget {
  const SmeIpoView({super.key});

  @override
  State<SmeIpoView> createState() => _SmeIpoViewState();
}

class _SmeIpoViewState extends State<SmeIpoView> {
  String type = "Current";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CoreAppBar(
        title: "$type SME Ipo",
        centerTitle: false,
        showBackButton: false,
      ),
      body: _smeIpoController.obx(
        (state) {
          return state?.data?.isEmpty == true
              ? CustomErrorOrEmpty(
                  title: "No $type MainBoard IPO's",
                )
              : Scrollbar(
                  thumbVisibility: true,
                  thickness: 6,
                  radius: const Radius.circular(8),
                  child: ListView.separated(
                    itemCount: state?.data?.length ?? 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      final data = state?.data?[index];
                      return GestureDetector(
                        onTap: () => MyNavigator.pushNamed(
                          GoPaths.ipoDetails,
                          extra: {
                            'slug': data?.href,
                            'name': data?.companyName,
                          },
                        ),
                        child: MainboardUpcomingCard(
                          name: data?.companyName ?? "",
                          bid: "₹${data?.price}",
                          size: data?.size,
                          markets: data?.exchange ?? [],
                          leadManager: data?.leadManager,
                          marketMaker: data?.marketMaker,
                          data: [
                            if (data?.price != null)
                              KeyValuePairModel(
                                key: "Start Date:",
                                value: "${data?.open}",
                              ),
                            if (data?.lot != null)
                              KeyValuePairModel(
                                key: "Close Date:",
                                value: "${data?.close}",
                              ),
                            if (data?.open != null)
                              KeyValuePairModel(
                                key: "Listing Date:",
                                value: data?.listing ?? "",
                              ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  ),
                );
        },
        onError: (error) => TryAgainWidget(
          onTap: _smeIpoController.getSmeData(type: "upcoming"),
        ),
        onEmpty: TryAgainWidget(
          onTap: _smeIpoController.getSmeData(type: "upcoming"),
        ),
      ),
      floatingActionButton: _offsetPopup(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _offsetPopup() => PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 34,
            onTap: () {
              _smeIpoController.getSmeData(type: "upcoming");
              setState(() {
                type = "Upcoming";
              });
            },
            child: Text(
              "Upcoming Ipo",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 34,
            onTap: () {
              _smeIpoController.getSmeData(type: "current");
              setState(() {
                type = "Current";
              });
            },
            child: Text(
              "Current Ipo",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          PopupMenuItem(
            value: 3,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 34,
            onTap: () {
              _smeIpoController.getSmeData(type: "past");
              setState(() {
                type = "Past";
              });
            },
            child: Text(
              "Past Ipo",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
        icon: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor.withOpacity(0.8),
          ),
          child: const Icon(
            Icons.keyboard_arrow_up_sharp,
            color: Colors.white,
          ),
        ),
      );
}
