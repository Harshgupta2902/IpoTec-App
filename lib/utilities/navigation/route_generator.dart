import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipotec/dashboard_module/view/blogs/blogs_main_view.dart';
import 'package:ipotec/dashboard_module/view/buyback/buyback_ipo_details_view.dart';
import 'package:ipotec/dashboard_module/view/buyback/buyback_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/common_details_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/ipo_forms_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/ipo_gmp_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/ipo_subs_view.dart';
import 'package:ipotec/dashboard_module/view/no_internet.dart';
import 'package:ipotec/dashboard_module/view/upcoming/mainboard_ipo_details_view.dart';
import 'package:ipotec/dashboard_module/view/upcoming/mainboard_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/landingview.dart';
import 'package:ipotec/dashboard_module/view/search_main_view.dart';
import 'package:ipotec/dashboard_module/view/upcoming/sme_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/web_view.dart';
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
      path: GoPaths.commonDetails,
      name: GoPaths.commonDetails,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final slug = extras['slug'];
        final name = extras['name'];
        return CommonDetailsView(
          slug: slug,
          name: name,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.forms,
      name: GoPaths.forms,
      builder: (context, state) {
        return const IpoFormsView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.gmp,
      name: GoPaths.gmp,
      builder: (context, state) {
        return const IpoGmpView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.subs,
      name: GoPaths.subs,
      builder: (context, state) {
        return const IpoSubsView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.noInternet,
      name: GoPaths.noInternet,
      builder: (context, state) {
        return const NoInternet();
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
