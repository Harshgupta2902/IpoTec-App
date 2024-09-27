import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/buyback_ipo_controller.dart';
import 'package:ipotec/dashboard_module/controller/mainboard_ipo_controller.dart';
import 'package:ipotec/utilities/common/core_update_handler.dart';
import 'package:ipotec/utilities/common/custom_bottom_navigation.dart';
import 'package:ipotec/utilities/common/default_app_drawer.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _hiddenDrawerController = Get.put(HiddenDrawerController());
final _mainBoardIpoController = Get.put(MainBoardIpoController());
final _buybackIpoController = Get.put(BuybackBoardIpoController());

class LandingView extends StatefulWidget {
  const LandingView({super.key, required this.child});
  final Widget child;
  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _mainBoardIpoController.getMainboardData();
        _buybackIpoController.getBuybackData();
      },
    );
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        return checkUpdate();
      },
    );
    super.initState();
  }

  void checkUpdate() async {
    await appUpdateCheck(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _hiddenDrawerController.scaffoldKey,
      body: widget.child,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
    // return Scaffold(
    //   body: Obx(
    //     () => GestureDetector(
    //       onTap: () {
    //         if (_hiddenDrawerController.isDrawerOpen.value == false) {
    //           return;
    //         }
    //         _hiddenDrawerController.toggleDrawer();
    //       },
    //       child: AnimatedContainer(
    //         transform: Matrix4.translationValues(
    //           _hiddenDrawerController.xOffset.value,
    //           _hiddenDrawerController.yOffset.value,
    //           0,
    //         )..scale(
    //             _hiddenDrawerController.scaleFactor.value,
    //           ),
    //         duration: const Duration(
    //           milliseconds: 250,
    //         ),
    //         curve: Curves.easeInOut,
    //         decoration: AppBoxDecoration.getBoxDecoration(
    //           showShadow: true,
    //           color: AppColors.backgroundColor,
    //           borderRadius: _hiddenDrawerController.isDrawerOpen.value ? 40 : 0.0,
    //           spreadRadius: _hiddenDrawerController.isDrawerOpen.value ? 1 : 0,
    //           blurRadius: 24,
    //         ),
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(
    //             _hiddenDrawerController.isDrawerOpen.value ? 24 : 0.0,
    //           ),
    //           child: IgnorePointer(
    //             ignoring: _hiddenDrawerController.isDrawerOpen.value,
    //             child: Scaffold(
    //               key: _hiddenDrawerController.scaffoldKey,
    //               body: widget.child,
    //               drawer: const DefaultCustomDrawer(),
    //               bottomNavigationBar: const CustomBottomNavigationBar(),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
