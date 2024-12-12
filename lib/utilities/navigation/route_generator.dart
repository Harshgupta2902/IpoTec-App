import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipotec/auth_module/view/login_view.dart';
import 'package:ipotec/dashboard_module/view/blogs/blogs_main_view.dart';
import 'package:ipotec/dashboard_module/view/bottom/mainboard_ipo_details_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/ipo_gmp_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/ipo_performance_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/mainboard_calendar_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/mainboard_ipo_subs_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/sme_calendar_view.dart';
import 'package:ipotec/dashboard_module/view/drawer/sme_ipo_subs_view.dart';
import 'package:ipotec/dashboard_module/view/no_internet.dart';
import 'package:ipotec/dashboard_module/view/policy_view.dart';
import 'package:ipotec/dashboard_module/view/bottom/mainboard_ipo_view.dart';
import 'package:ipotec/dashboard_module/view/landing_view.dart';
import 'package:ipotec/dashboard_module/view/search_main_view.dart';
import 'package:ipotec/dashboard_module/view/bottom/sme_ipo_view.dart';
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
          path: GoPaths.gmp,
          name: GoPaths.gmp,
          builder: (context, state) {
            return const IpoGmpView();
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
      path: GoPaths.login,
      name: GoPaths.login,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final type = extras['type'];
        return LoginView(callType: type);
      },
    ),

    // ------------------   Calendar Page Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.mainCalendar,
      name: GoPaths.mainCalendar,
      builder: (context, state) {
        return const MainboardCalendarView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.smeCalendar,
      name: GoPaths.smeCalendar,
      builder: (context, state) {
        return const SmeCalendarView();
      },
    ),

    // ------------------   Performance Page Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.performance,
      name: GoPaths.performance,
      builder: (context, state) {
        return const IpoPerformanceView();
      },
    ),

    // ------------------   Subscription Page Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.mainSubs,
      name: GoPaths.mainSubs,
      builder: (context, state) {
        return const MainBoardIpoSubsView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.smeSubs,
      name: GoPaths.smeSubs,
      builder: (context, state) {
        return const SmeIpoSubsView();
      },
    ),

    // ------------------   OTHER EXTRA  Routes   ---------------------------

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
      path: GoPaths.policyView,
      name: GoPaths.policyView,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final type = extras['type'];
        final policy = extras['policy'];
        return PolicyView(type: type, policy: policy);
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

    // ------------------   SEARCH Routes   ---------------------------

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
