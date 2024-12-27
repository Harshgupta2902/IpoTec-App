// import 'package:flutter/material.dart';
// import 'package:ipotec/utilities/theme/app_colors.dart';
//
// class NoInternet extends StatelessWidget {
//   const NoInternet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: Center(
//         child: Text("No INternt"),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  late StreamSubscription subscription;

  getConnectivity() {
    final internetChecker = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 10),
      checkInterval: const Duration(seconds: 5),
    );
    return subscription = internetChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (ModalRoute.of(context)?.settings.name == GoPaths.noInternet) {
            MyNavigator.popUntilAndPushNamed(GoPaths.mainBoard);
          }
          break;
        case InternetConnectionStatus.disconnected:
          if (ModalRoute.of(context)?.settings.name != GoPaths.noInternet) {
            MyNavigator.pushNamed(GoPaths.noInternet);
          }
          break;
      }
    });
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Center(
                child: Lottie.asset(AssetPath.noInternet),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
