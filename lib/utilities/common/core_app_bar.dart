import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

final _hiddenDrawerController = Get.put(HiddenDrawerController());

class CoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? showActions;
  final String? title;
  final bool? showBackButton;
  final bool? centerTitle;
  final Widget? titleWidget;

  const CoreAppBar({
    super.key,
    this.title,
    this.showActions = true,
    this.showBackButton = true,
    this.centerTitle,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      title: titleWidget ??
          Text(
            title ?? "-",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
      centerTitle: centerTitle ?? true,
      leading: showBackButton == true
          ? GestureDetector(
              onTap: () {
                MyNavigator.pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            )
          // : null,
          : GestureDetector(
              onTap: () => _hiddenDrawerController.scaffoldKey.currentState?.openDrawer(),
              child: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
      actions: showActions == true || _hiddenDrawerController.showSearchBar.value == true
          ? [
              GestureDetector(
                onTap: () {
                  MyNavigator.pushNamed(GoPaths.search);
                },
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: Icon(Icons.search)),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
