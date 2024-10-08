import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _hiddenDrawerController = Get.put(HiddenDrawerController());

class DefaultCustomDrawer extends StatefulWidget {
  const DefaultCustomDrawer({
    super.key,
  });

  @override
  State<DefaultCustomDrawer> createState() => _DefaultCustomDrawerState();
}

class _DefaultCustomDrawerState extends State<DefaultCustomDrawer> with TickerProviderStateMixin {
  final List<KeyValuePairModel> menuItems = [
    KeyValuePairModel(key: "IPO GMP", value: AssetPath.gmp),
    KeyValuePairModel(key: "IPO Subscription", value: AssetPath.subs),
    KeyValuePairModel(key: "Upcoming IPO", value: AssetPath.mainBoard),
    KeyValuePairModel(key: "SME IPO", value: AssetPath.sme),
    KeyValuePairModel(key: "BuyBack IPO", value: AssetPath.buyBack),
    KeyValuePairModel(key: "IPO Forms", value: AssetPath.forms),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      child: TapRegion(
        onTapOutside: (event) {
          _hiddenDrawerController.scaffoldKey.currentState?.closeDrawer();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 8,
          ),
          child: Container(
            margin: EdgeInsets.only(
              left: 12,
              right: MediaQuery.of(context).size.width * 0.24,
              top: 24,
              bottom: 10,
            ),
            decoration: AppBoxDecoration.getBoxDecoration(
              showShadow: false,
              borderRadius: 16,
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.16,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1636956040469-fec02ed01ab5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        CachedImageNetworkContainer(
                          decoration: AppBoxDecoration.getBoxDecoration(
                            borderRadius: 40,
                            showShadow: true,
                          ),
                          url:
                              "https://images.unsplash.com/photo-1705904506582-6552c35a2dc4?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          placeHolder: buildPlaceholder(name: "H", context: context),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "HelloHelloHelloHelloHelloHelloHelloHello",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                "HelloHelloHelloHelloHelloHelloHelloHello",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration: AppBoxDecoration.getBoxDecoration(
                          showShadow: false,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            dynamicImage(
                                image: menuItems[index].value == ""
                                    ? AssetPath.sme
                                    : menuItems[index].value),
                            const SizedBox(width: 14),
                            Text(
                              menuItems[index].key,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.whiteSmoke,
                      backgroundColor: AppColors.desertStorm,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      await clearPrefs();
                      Future.delayed(
                        Duration.zero,
                        () => MyNavigator.popUntilAndPushNamed(GoPaths.mainBoard),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetPath.logOutSvg),
                        const SizedBox(width: 8),
                        Text(
                          "Logout",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget dynamicImage({
  String? image,
  double? height,
  double? width,
}) {
  final isNetworkImage = image?.startsWith("https") == true;

  if (isNetworkImage == true) {
    if (image!.endsWith(".svg")) {
      return SvgPicture.network(
        image,
        height: height ?? 24,
        width: width ?? 24,
        semanticsLabel: 'Custom Image',
        fit: BoxFit.fill,
      );
    }
    if (image.endsWith(".png")) {
      return Image.network(
        image,
        height: height ?? 24,
        width: width ?? 24,
        fit: BoxFit.fill,
      );
    }
  }

  if (image!.contains(".png")) {
    return Image.asset(
      image,
      height: height ?? 24,
      width: width ?? 24,
      fit: BoxFit.fill,
    );
  }

  if (image.contains(".svg")) {
    return SvgPicture.asset(
      image,
      height: height ?? 24,
      width: width ?? 24,
      semanticsLabel: 'Custom Image',
      fit: BoxFit.fill,
    );
  }

  return const SizedBox();
}
