import 'package:flutter/material.dart';
import 'package:ipotec/utilities/navigation/route_generator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:ipotec/utilities/theme/smooth_rectangular_border.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
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
      title: 'IpoTec',
      routerConfig: goRouterConfig,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,
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
