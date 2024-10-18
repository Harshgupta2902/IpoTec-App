import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/auth_controller.dart';
import 'package:ipotec/auth_module/view/login_view.dart';
import 'package:ipotec/dashboard_module/controller/default_controller.dart';
import 'package:ipotec/dashboard_module/view/policy_view.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _hiddenDrawerController = Get.put(HiddenDrawerController());
final _authController = Get.put(AuthController());
final _defaultController = Get.put(DefaultApiController());

class DefaultCustomDrawer extends StatefulWidget {
  const DefaultCustomDrawer({
    super.key,
  });

  @override
  State<DefaultCustomDrawer> createState() => _DefaultCustomDrawerState();
}

class _DefaultCustomDrawerState extends State<DefaultCustomDrawer> with TickerProviderStateMixin {
  final List<KeyValuePairModel> menuItems = [
    KeyValuePairModel(
      key: "IPO GMP",
      value: AssetPath.gmp,
      extra: GoPaths.gmp,
    ),
    KeyValuePairModel(
      key: "IPO Subscription",
      value: AssetPath.subs,
      extra: GoPaths.subs,
    ),
    KeyValuePairModel(
      key: "Upcoming IPO",
      value: AssetPath.mainBoard,
      extra: GoPaths.mainBoard,
    ),
    KeyValuePairModel(
      key: "SME IPO",
      value: AssetPath.sme,
      extra: GoPaths.sme,
    ),
    KeyValuePairModel(
      key: "BuyBack IPO",
      value: AssetPath.buyBack,
      extra: GoPaths.buyBack,
    ),
    KeyValuePairModel(
      key: "IPO Forms",
      value: AssetPath.forms,
      extra: GoPaths.forms,
    )
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
            clipBehavior: Clip.hardEdge,
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
                      image: AssetImage(AssetPath.greenBg),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          isLoggedIn()
                              ? CachedImageNetworkContainer(
                                  decoration: AppBoxDecoration.getBoxDecoration(
                                    borderRadius: 40,
                                    showShadow: true,
                                  ),
                                  height: 40,
                                  width: 40,
                                  url: _authController.state?.photoURL,
                                  placeHolder: buildPlaceholderSVG(assetPath: AssetPath.avatarSvg),
                                )
                              : SvgPicture.asset(
                                  AssetPath.avatarSvg,
                                  height: 40,
                                  width: 40,
                                ),
                          const SizedBox(width: 12),
                          isLoggedIn()
                              ? Text(
                                  "${_authController.state?.displayName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.white),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    _hiddenDrawerController.scaffoldKey.currentState?.closeDrawer();
                                    MyNavigator.pushNamed(GoPaths.login, extra: {
                                      'type': CallApiType.none,
                                    });
                                  },
                                  child: Text(
                                    "Click Here To Sign In",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                        ],
                      ),
                      if (isLoggedIn()) ...[
                        const SizedBox(height: 6),
                        Text(
                          "${_authController.state?.email}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                        ),
                      ]
                    ],
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height * 0.16,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(AssetPath.greenBg),
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         children: [
                //           isLoggedIn()
                //               ? CachedImageNetworkContainer(
                //                   decoration: AppBoxDecoration.getBoxDecoration(
                //                     borderRadius: 40,
                //                     showShadow: true,
                //                   ),
                //                   height: 40,
                //                   width: 40,
                //                   url: _authController.state?.photoURL,
                //                   placeHolder: buildPlaceholderSVG(assetPath: AssetPath.avatarSvg),
                //                 )
                //               : SvgPicture.asset(
                //                   AssetPath.avatarSvg,
                //                   height: 40,
                //                   width: 40,
                //                 ),
                //           const SizedBox(width: 12),
                //           isLoggedIn()
                //               ? Text(
                //                   "${_authController.state?.displayName}",
                //                   maxLines: 1,
                //                   overflow: TextOverflow.ellipsis,
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleSmall
                //                       ?.copyWith(color: Colors.white),
                //                 )
                //               : GestureDetector(
                //                   onTap: () {
                //                     _hiddenDrawerController.scaffoldKey.currentState?.closeDrawer();
                //                     MyNavigator.pushNamed(GoPaths.login, extra: {
                //                       'type': CallApiType.none,
                //                     });
                //                   },
                //                   child: Text(
                //                     "Click Here To Sign In",
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .titleSmall
                //                         ?.copyWith(color: Colors.white),
                //                   ),
                //                 ),
                //         ],
                //       ),
                //       if (isLoggedIn()) ...[
                //         const SizedBox(height: 6),
                //         Text(
                //           "${_authController.state?.email}",
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style:
                //               Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                //         ),
                //       ]
                //     ],
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _defaultController.state?.menuItems?.length ?? 0,
                    itemBuilder: (context, index) {
                      final data = _defaultController.state?.menuItems?[index];
                      return GestureDetector(
                        onTap: () {
                          _hiddenDrawerController.scaffoldKey.currentState?.closeDrawer();
                          if (isLoggedIn()) {
                            MyNavigator.pushNamed(data?.path);
                          } else if (data?.path == GoPaths.gmp || data?.path == GoPaths.subs) {
                            MyNavigator.pushNamed(
                              GoPaths.login,
                              extra: {
                                'type':
                                    data?.path == GoPaths.gmp ? CallApiType.gmp : CallApiType.subs
                              },
                            );
                          } else if (data?.path == GoPaths.policyView &&
                              data?.key == "Privacy Policy") {
                            MyNavigator.pushNamed(
                              GoPaths.policyView,
                              extra: {
                                'type': PolicyType.privacy,
                                'policy': _defaultController.state?.privacy,
                              },
                            );
                          } else if (data?.path == GoPaths.policyView &&
                              data?.key == "Terms & Conditions") {
                            MyNavigator.pushNamed(
                              GoPaths.policyView,
                              extra: {
                                'type': PolicyType.terms,
                                'policy': _defaultController.state?.terms,
                              },
                            );
                          } else if (data?.path == GoPaths.contactUs) {
                            launchEmail(email: "harsh1248gupta@gmail.com");
                          } else {
                            MyNavigator.pushNamed(data?.path);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                          decoration: AppBoxDecoration.getBoxDecoration(
                            showShadow: false,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              dynamicImage(
                                image: getDrawerLogo(data?.key ?? ""),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                data?.key ?? "",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isLoggedIn() == true)
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
                        _authController.googleSignOut(context);
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
