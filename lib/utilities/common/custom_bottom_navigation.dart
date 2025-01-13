// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/ipo_module/controller/default_controller.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _defaultController = Get.put(DefaultApiController());

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _index = 2;

  List<KeyValuePairModel> bars = [
    KeyValuePairModel(key: AssetPath.mainBoard, value: "Mainboard"),
    KeyValuePairModel(key: AssetPath.sme, value: "SME"),
    KeyValuePairModel(key: AssetPath.gmp, value: "GMP"),
    KeyValuePairModel(key: AssetPath.allotment, value: "Allotment"),
    KeyValuePairModel(key: AssetPath.blogs, value: "Blogs"),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          if (value == 3) {
            return;
          }
          _index = value;
        });
        _onItemTapped(value);
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
              height: 24,
              width: 24,
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
      MyNavigator.pushReplacementNamed(GoPaths.mainBoard);
      break;
    case 1:
      MyNavigator.pushReplacementNamed(GoPaths.sme);
      break;
    case 2:
      MyNavigator.pushReplacementNamed(GoPaths.gmp);
      break;
    case 3:
      MyNavigator.pushNamed(
        GoPaths.webView,
        extra: {
          'title': "Ipo Allotment",
          'url': _defaultController.state?.allotment ?? "https://ris.kfintech.com/ipostatus/",
        },
      );
      break;
    case 4:
      MyNavigator.pushReplacementNamed(GoPaths.blogs);
      break;
    default:
      MyNavigator.pushReplacementNamed(GoPaths.mainBoard);
  }
}
