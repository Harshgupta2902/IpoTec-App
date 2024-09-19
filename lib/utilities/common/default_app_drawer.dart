import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
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
                children: <Widget>[
                  const SizedBox(height: 20),
                  SvgPicture.asset("packages/utilities/assets/logo.svg"),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
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
                                    dynamicImage(image: AssetPath.sme),
                                    const SizedBox(width: 14),
                                    Text(
                                      "sme",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      const Divider(
                        height: 1.5,
                        endIndent: 20,
                        indent: 20,
                        color: AppColors.iron,
                        thickness: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.whiteSmoke,
                              backgroundColor: AppColors.desertStorm,
                              elevation: 0),
                          onPressed: () async {
                            context.go("/login", extra: {"number": ""});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("packages/utilities/assets/logout.svg"),
                              const SizedBox(width: 8),
                              Text(
                                "Logout",
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      letterSpacing: 0.15,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6)
                    ],
                  )
                ],
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
