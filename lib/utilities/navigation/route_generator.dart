import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipotec/dashboard_module/view/buyback_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/mainboard_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/landingview.dart';
import 'package:ipotec/dashboard_module/view/sme_ipo_view.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
final GoRouter goRouterConfig = GoRouter(
  initialLocation: GoPaths.mainBoard,
  navigatorKey: rootNavigatorKey,
  routes: [
    //
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return LandingView(
          child: child,
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: GoPaths.mainBoard,
          name: GoPaths.mainBoard,
          builder: (context, state) {
            return const MainBoardIpoView();
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: GoPaths.sme,
          name: GoPaths.sme,
          builder: (context, state) {
            return const SmeIpoView();
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: GoPaths.buyBack,
          name: GoPaths.buyBack,
          builder: (context, state) {
            return const BuybackIpoView();
          },
        ),
      ],
    ),

    // ------------------   Registration Page Routes   ---------------------------
    // GoRoute(
    //   parentNavigatorKey: rootNavigatorKey,
    //   path: GoPaths.login,
    //   name: GoPaths.login,
    //   builder: (context, state) {
    //     final extras = state.extra as Map<String, dynamic>;
    //     final number = extras['number'];
    //     return LoginView(number: number);
    //   },
    // ),
    //
    // GoRoute(
    //   parentNavigatorKey: rootNavigatorKey,
    //   path: GoPaths.otp,
    //   name: GoPaths.otp,
    //   builder: (context, state) {
    //     final extras = state.extra as Map<String, dynamic>;
    //     final phone = extras['phone'];
    //     final path = extras['path'];
    //     return OtpView(
    //       number: phone,
    //       path: path,
    //     );
    //   },
    // ),
  ],
);
