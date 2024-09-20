import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
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
              color: index == _index ? AppColors.primaryColor : Colors.black,
            ),
            label: bars[index].value,
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
    default:
      MyNavigator.go(GoPaths.sme);
  }
}
