import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ipotec/dashboard_module/controller/default_controller.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/firebase/analytics_service.dart';
import 'package:ipotec/utilities/firebase/crashlytics_service.dart';
import 'package:ipotec/utilities/firebase/notification_service.dart';
import 'package:ipotec/utilities/navigation/route_generator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:ipotec/utilities/theme/smooth_rectangular_border.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final _defaultController = Get.put(DefaultApiController());

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCq0YE2b8xWC3RGOLhGwcu8sLCL67j81qk",
        appId: "1:198625871212:android:67a6e80d65fe20fe661f49",
        messagingSenderId: "198625871212",
        projectId: "ipotech-41d68",
      ),
    );
  }
  if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = (FlutterErrorDetails details) {
    if ((details.library == 'image resource service' || details.library == 'Invalid image data') &&
        (details.exception.toString().contains('404') ||
            details.exception.toString().contains('403'))) {
      debugPrint('Suppressed cachedNetworkImage Exception');
      return;
    }
    FlutterError.presentError(details);
  };

  await CoreNotificationService().init();
  if (kReleaseMode) {
    CrashlyticsService().init();
  }
  await _defaultController.getDefaultData();
  // MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseAnalyticsService().init("");
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    try {
      final Map payload = message.data;
      CoreNotificationService().onNotificationClicked(payload: payload);
    } catch (e) {
      logger.e("onDidReceiveNotificationResponse error $e");
    }
  });
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    CoreNotificationService().fcmListener();
    // CoreNotificationService().updateFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final boldText = MediaQuery.boldTextOf(context);
        final newMediaQueryData = MediaQuery.of(context).copyWith(
          boldText: boldText,
          textScaler: const TextScaler.linear(1.0),
        );

        return MediaQuery(
          data: newMediaQueryData,
          child: child!,
        );
      },
      title: 'IPO Live GMP - IpoTec',
      routerConfig: goRouterConfig,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        primaryColor: AppColors.primaryColor,
        fontFamily: 'Poppins',
        switchTheme: const SwitchThemeData(
          splashRadius: 0,
        ),
        popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.white,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.vertical(
              top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
            ),
          ),
          showDragHandle: true,
          dragHandleSize: Size(60, 4),
          clipBehavior: Clip.hardEdge,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.alabaster,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.paleSky),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 10,
                cornerSmoothing: 1.0,
              ),
            ),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 10,
              ),
            ),
            foregroundColor: Colors.white,
            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.15),
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
