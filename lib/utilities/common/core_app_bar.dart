import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _hiddenDrawerController = Get.put(HiddenDrawerController());

class CoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? showActions;
  final String? title;
  final bool? showBackButton;
  final bool? centerTitle;
  final Widget? titleWidget;
  final Widget? openBrowser;
  final Color? appBarColor;
  final bool? showBorder;
  final Color? leadingColor;

  const CoreAppBar({
    super.key,
    this.title,
    this.showActions = true,
    this.showBackButton = true,
    this.centerTitle,
    this.titleWidget,
    this.openBrowser,
    this.appBarColor,
    this.showBorder = false,
    this.leadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor ?? Colors.white,
      scrolledUnderElevation: 0,
      title: titleWidget ??
          Text(
            title ?? "-",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
      centerTitle: centerTitle ?? true,
      shape: showBorder == true
          ? const Border(
              bottom: BorderSide(color: AppColors.silverChalice30),
            )
          : null,
      leading: showBackButton == true
          ? GestureDetector(
              onTap: () {
                MyNavigator.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: leadingColor ?? Colors.black,
              ),
            )
          : GestureDetector(
              onTap: () => _hiddenDrawerController.scaffoldKey.currentState?.openDrawer(),
              child: Icon(
                Icons.menu,
                color: leadingColor ?? Colors.black,
              ),
            ),
      actions: [
        if (openBrowser != null) ...[
          openBrowser!,
          const SizedBox(width: 12),
        ]
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
