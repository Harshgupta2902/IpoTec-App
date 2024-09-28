// ignore: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/default_controller.dart';
import 'package:ipotec/utilities/common/drawer_controller.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/packages/ad_helper.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _defaultController = Get.put(DefaultApiController());
final _hiddenDrawerController = Get.put(HiddenDrawerController());

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _index = 0;

  List<KeyValuePairModel> bars = [
    KeyValuePairModel(key: AssetPath.mainBoard, value: "Mainboard"),
    KeyValuePairModel(key: AssetPath.sme, value: "SME"),
    KeyValuePairModel(key: AssetPath.buyBack, value: "Buyback"),
    KeyValuePairModel(key: AssetPath.blogs, value: "Blogs"),
  ];
  // InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
  }

  // void _loadInterstitialAd(int index) {
  //   InterstitialAd.load(
  //     adUnitId: AdHelper.interstitialAdUnitId,
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {
  //             _onItemTapped(index);
  //           },
  //         );
  //
  //         setState(() {
  //           _interstitialAd = ad;
  //         });
  //       },
  //       onAdFailedToLoad: (err) {
  //         debugPrint('Failed to load an interstitial ad: ${err.message}');
  //         _onItemTapped(index);
  //       },
  //     ),
  //   );
  // }

  @override
  void dispose() {
    // _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          _index = value;
          if (_index == 3) {
            _hiddenDrawerController.showSearchBar.value = false;
          }
        });
        _onItemTapped(value);
        // if (_defaultController.state?.showAd == true) {
        //   _loadInterstitialAd(value);
        // } else {
        //
        // }
      },
      backgroundColor: Colors.white,
      currentIndex: _index,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.black,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      items: List.generate(
        bars.length,
        (index) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              bars[index].key,
              color: index == _index ? AppColors.primaryColor : Colors.black,
            ),
            label: bars[index].value,
            tooltip: bars[index].value,
          );
        },
      ),
    );
  }
}

void _onItemTapped(int index) {
  switch (index) {
    case 0:
      MyNavigator.go(GoPaths.mainBoard);
      break;
    case 1:
      MyNavigator.go(GoPaths.sme);
      break;
    case 2:
      MyNavigator.go(GoPaths.buyBack);
      break;

    case 3:
      MyNavigator.go(GoPaths.blogs);
      break;

    default:
      MyNavigator.go(GoPaths.mainBoard);
  }
}
