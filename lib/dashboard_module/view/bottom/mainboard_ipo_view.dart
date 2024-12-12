import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/mainboard_upcoming_card.dart';
import 'package:ipotec/dashboard_module/controller/bottom/mainboard_ipo_controller.dart';
import 'package:ipotec/dashboard_module/controller/default_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _mainBoardIpoController = Get.put(MainBoardIpoController());
final _defaultApiController = Get.put(DefaultApiController());

class MainBoardIpoView extends StatelessWidget {
  const MainBoardIpoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "MainBoard Ipo",
        centerTitle: false,
        showBackButton: false,
      ),
      body: _mainBoardIpoController.obx(
        (state) {
          return ListView.separated(
            itemCount: state?.data?.length ?? 0,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final data = state?.data?[index];
              return GestureDetector(
                // onTap: () => MyNavigator.pushNamed(
                //   GoPaths.mainBoardDetails,
                //   extra: {'slug': data?.searchId, 'name': data?.growwShortName},
                // ),
                child: MainboardUpcomingCard(
                  name: data?.companyName ?? "",
                  bid: "₹${data?.price}",
                  size: data?.size,
                  markets: data?.exchange ?? [],
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
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          );
        },
        onError: (error) => TryAgainWidget(
          onTap: () {
            _mainBoardIpoController.getMainboardData(type: "upcoming");
            _defaultApiController.getDefaultData();
          },
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
              _mainBoardIpoController.getMainboardData(type: "upcoming");
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
              _mainBoardIpoController.getMainboardData(type: "current");
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
              _mainBoardIpoController.getMainboardData(type: "past");
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
