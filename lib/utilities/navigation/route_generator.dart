import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipotec/auth_module/view/splash_screen.dart';
import 'package:ipotec/dashboard_module/view/blogs_main_view.dart';
import 'package:ipotec/dashboard_module/view/buyback_ipo_details_view.dart';
import 'package:ipotec/dashboard_module/view/buyback_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/mainboard_ipo_details_view.dart';
import 'package:ipotec/dashboard_module/view/mainboard_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/landingview.dart';
import 'package:ipotec/dashboard_module/view/search_main_view.dart';
import 'package:ipotec/dashboard_module/view/sme_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/web_view.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
final GoRouter goRouterConfig = GoRouter(
  initialLocation: GoPaths.splash,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.splash,
      name: GoPaths.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),

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
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: GoPaths.blogs,
          name: GoPaths.blogs,
          builder: (context, state) {
            return const BlogsMainView();
          },
        ),
      ],
    ),

    // ------------------   Registration Page Routes   ---------------------------
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.mainBoardDetails,
      name: GoPaths.mainBoardDetails,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final slug = extras['slug'];
        final name = extras['name'];
        return MainboardIpoDetailsView(
          slug: slug,
          name: name,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.buyBackDetails,
      name: GoPaths.buyBackDetails,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final slug = extras['slug'];
        final name = extras['name'];
        return BuybackIpoDetailsView(
          slug: slug,
          name: name,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.webView,
      name: GoPaths.webView,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final url = extras['url'];
        final title = extras['title'];
        return WebView(
          url: url,
          title: title,
        );
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.search,
      name: GoPaths.search,
      builder: (context, state) {
        return const SearchMainView();
      },
    ),
  ],
);
