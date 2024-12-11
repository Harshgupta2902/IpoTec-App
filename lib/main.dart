import 'dart:async';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ipotec/dashboard_module/controller/default_controller.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/firebase/analytics_service.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/firebase/crashlytics_service.dart';
import 'package:ipotec/utilities/firebase/notification_service.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/navigation/route_generator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:ipotec/utilities/theme/smooth_rectangular_border.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  CoreNotificationService().onNotificationClicked(payload: message.data);
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final _defaultController = Get.put(DefaultApiController());

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  if (!kReleaseMode) {
    setStaticPref();
  }

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBLIHPmeDp4lm15m53WZ7R5PwmyY08TsGI",
        appId: "1:746316186479:android:38d5963da3f3e4769ede9a",
        messagingSenderId: "746316186479",
        projectId: "ipotec-app",
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
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await analytics.logEvent(
    name: "app_start",
  );

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

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    try {
      CoreNotificationService().onNotificationClicked(payload: message.data);
      (message.data); // Navigate to the correct route
    } catch (e) {
      logger.e("onMessage error $e");
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
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
  final FirebaseAnalyticsObserver analyticsObserver = FirebaseAnalyticsObserver(
    analytics: FirebaseAnalytics.instance,
  );
  late final ConnectivityService _connectivityService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver;
    super.initState();
    _connectivityService = ConnectivityService(context);
    debugPrint("getconnectivit startListening");
    _connectivityService.startListening();
    CoreNotificationService().fcmListener();
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
        fontFamily: 'Quicksand',
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

class ConnectivityService with WidgetsBindingObserver {
  final BuildContext context;

  ConnectivityService(this.context);

  StreamSubscription? _subscription;
  bool _isNoInternetRouteActive = false;
  void startListening() {
    WidgetsBinding.instance.addObserver(this);
    debugPrint("getconnectivit started");
    _subscription = getConnectivity();
  }

  void stopListening() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
  }

  StreamSubscription<void> getConnectivity() {
    final internetChecker = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 10),
      checkInterval: const Duration(seconds: 5),
    );

    return internetChecker.onStatusChange.listen(
      (status) {
        debugPrint("Internet  $status.");
        switch (status) {
          case InternetConnectionStatus.connected:
            if (ModalRoute.of(context)?.settings.name == GoPaths.noInternet &&
                _isNoInternetRouteActive) {
              debugPrint("Internet restored, popping the no internet screen.");
              MyNavigator.popUntilAndPushNamed(GoPaths.mainBoard);
              _isNoInternetRouteActive = false; // Reset the flag when internet is restored
            }
            break;

          case InternetConnectionStatus.disconnected:
            if (!_isNoInternetRouteActive) {
              debugPrint("Internet disconnected, pushing the no internet screen.");
              _isNoInternetRouteActive = true; // Set the flag when route is pushed
              Future.delayed(const Duration(seconds: 2), () {
                if (ModalRoute.of(context)?.settings.name != GoPaths.noInternet) {
                  MyNavigator.pushNamed(GoPaths.noInternet);
                }
              });
            }
            break;
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _subscription = getConnectivity();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      debugPrint("stream caceleted");
      _subscription?.cancel();
    }
  }
}
