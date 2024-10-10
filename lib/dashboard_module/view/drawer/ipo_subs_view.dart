import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/ipo_subs_card.dart';
import 'package:ipotec/dashboard_module/controller/drawer/ipo_subs_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';

final _ipoSubsController = Get.put(IpoSubsController());

class IpoSubsView extends StatefulWidget {
  const IpoSubsView({super.key});

  @override
  State<IpoSubsView> createState() => _IpoSubsViewState();
}

class _IpoSubsViewState extends State<IpoSubsView> {
  @override
  void initState() {
    _ipoSubsController.getSubsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "Ipo Subscription",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _ipoSubsController.obx(
        (state) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const CustomTabBar(
                  tabList: ["MainBoard ", "SME"],
                  horizontalPadding: 16,
                  verticalPadding: 10,
                ),
                Flexible(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      IpoMainBoardSubsCard(state: state?.ipoSubscriptionData),
                      IpoSmeBoardSubsCard(state: state?.smeSubscriptionData),
                    ],
                  ),
                ),
              ],
            ),
          );
          // return ListView.separated(
          //   physics: const BouncingScrollPhysics(),
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   itemCount: state?.gmp?.length ?? 0,
          //   itemBuilder: (context, index) {
          //     final gmpData = state?.gmp?[index];
          //     return IpoGmpCard(state: gmpData);
          //   },
          //   separatorBuilder: (context, index) {
          //     return const SizedBox(height: 16);
          //   },
          // );
        },
      ),
    );
  }
}
