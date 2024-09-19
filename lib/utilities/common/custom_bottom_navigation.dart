import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/packages/blur_nav_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BlurNavbar(
      onTap: (idx) {
        setState(() {
          _index = idx;
          debugPrint('$idx');
        });
        _onItemTapped(idx);
      },
      items: [
        BlurNavbarItem(icon: SvgPicture.asset(AssetPath.mainBoard), title: "MainBoard"),
        BlurNavbarItem(icon: SvgPicture.asset(AssetPath.sme), title: "SME"),
        BlurNavbarItem(icon: SvgPicture.asset(AssetPath.buyBack), title: "Buyback"),
        BlurNavbarItem(icon: SvgPicture.asset(AssetPath.blogs), title: "Blogs"),
      ],
      currentIndex: _index,
      selectedColor: Colors.transparent,
      borderRadius: 12,
    );
  }
}

void _onItemTapped(int index) {
  switch (index) {
    case 0:
      MyNavigator.pushNamed(GoPaths.mainBoard);
      break;
    case 1:
      MyNavigator.pushNamed(GoPaths.sme);
      break;
    case 2:
      MyNavigator.pushNamed(GoPaths.mainBoard);
      break;
    default:
      MyNavigator.pushNamed(GoPaths.sme);
  }
}
