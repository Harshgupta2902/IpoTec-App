import 'package:flutter/material.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/route_generator.dart';

class MyNavigator {
  static String? currentRoute;

  static void pushNamed(String? routeName, {Object? extra}) {
    try {
      goRouterConfig.pushNamed(routeName ?? GoPaths.mainBoard, extra: extra);
    } catch (e) {
      debugPrint("+++++++++++++++++++++++++++++navigation  $e");
    }
  }

  static void go(String? routeName, {Object? extra}) {
    try {
      goRouterConfig.goNamed(routeName ?? GoPaths.mainBoard, extra: extra);
    } catch (e) {
      debugPrint("+++++++++++++++++++++++++++++navigation  $e");
    }
  }

  static void pop() {
    goRouterConfig.pop();
  }

  static void popUntilAndPushNamed(String routeName, {Object? extra}) {
    try {
      while (goRouterConfig.canPop()) {
        goRouterConfig.pop();
      }
      goRouterConfig.pushReplacementNamed(routeName, extra: extra);
    } catch (e) {
      debugPrint("Navigation Error: $e");
    }
  }

  static void pushReplacementNamed(String? routeName, {Object? extra}) {
    try {
      goRouterConfig.pushReplacementNamed(routeName ?? GoPaths.mainBoard, extra: extra);
    } catch (e) {
      debugPrint("+++++++++++++++++++++++++++++navigation  $e");
    }
  }
}
