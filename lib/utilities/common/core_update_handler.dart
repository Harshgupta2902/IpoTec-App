import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:ipotec/ipo_module/controller/default_controller.dart';
import 'package:ipotec/ipo_module/modal/default_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final _defaultDataController = Get.put(DefaultApiController());

appUpdateCheck({required BuildContext context}) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  DefaultModel? appUpdate = _defaultDataController.state;

  String buildNumber = packageInfo.buildNumber;
  bool updateAvailable = (appUpdate?.buildNo ?? 0) > int.parse(buildNumber);
  if (Platform.isIOS) {
    updateAvailable = (appUpdate?.iosBuildNo ?? 0) > int.parse(buildNumber);
  }

  if (updateAvailable == false) {
    return;
  }

  _handleInAppUpdate(appUpdate);

  if (appUpdate?.forceUpdate == 1) {
    Future.delayed(Duration.zero, () => _handleForceUpdate(appUpdate, context));
    return;
  }

  if (appUpdate?.softUpdate == 1) {
    return;
  }
}

getUniqueId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.id;
}

_handleInAppUpdate(DefaultModel? appUpdate) async {
  final updateInfo = await InAppUpdate.checkForUpdate();

  if (updateInfo.updateAvailability == UpdateAvailability.updateNotAvailable) {
    return;
  }

  if (appUpdate?.forceUpdate == 1) {
    debugPrint('FORCE UPDATE STARTED');
    InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
      if (appUpdateResult == AppUpdateResult.success) {}
    });
  } else if (appUpdate?.softUpdate == 1) {
    debugPrint('SOFT UPDATE STARTED');

    InAppUpdate.startFlexibleUpdate().then(
      (appUpdateResult) {
        if (appUpdateResult == AppUpdateResult.success) {
          InAppUpdate.startFlexibleUpdate();
        }
      },
    );
  }
}

_handleForceUpdate(DefaultModel? appUpdate, BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: CupertinoAlertDialog(
          title: Text(appUpdate?.title ?? 'Update Available'),
          content: Text(appUpdate?.message ?? 'A new version of the app is available.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Update'),
              onPressed: () async {
                openPlatformStore();
              },
            ),
            if (appUpdate?.forceUpdate == 0)
              CupertinoDialogAction(
                child: const Text('Close'),
                onPressed: () {
                  context.pop();
                },
              ),
          ],
        ),
      );
    },
  );
}

openPlatformStore() async {
  try {
    String? playStore = "com.ipotec";
    String? appStore = "";

    if (Platform.isAndroid && playStore.isEmpty == false) {
      final uri = 'market://details?id=$playStore';
      final url = Uri.parse(uri);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch Store URL';
      }
    } else {
      throw 'Could not launch Store URL';
    }

    if (Platform.isIOS && appStore.isEmpty == false) {
      final uri = 'https://apps.apple.com/gb/app/id$appStore';
      final url = Uri.parse(uri);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch Store URL';
      }
    } else {
      throw 'Could not launch Store URL';
    }
  } catch (e) {
    debugPrint(
      "Error opening  ${Platform.isAndroid ? 'play' : 'app'} store",
    );
  }
}
