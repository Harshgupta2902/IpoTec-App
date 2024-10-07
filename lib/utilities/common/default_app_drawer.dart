import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';

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
    KeyValuePairModel(key: "IPO GMP", value: ""),
    KeyValuePairModel(key: "IPO Subscription", value: ""),
    KeyValuePairModel(key: "Upcoming IPO", value: AssetPath.mainBoard),
    KeyValuePairModel(key: "SME IPO", value: AssetPath.sme),
    KeyValuePairModel(key: "BuyBack IPO", value: AssetPath.buyBack),
    KeyValuePairModel(key: "IPO Forms", value: ""),
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
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
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
            )),
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
