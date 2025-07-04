import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipotec/auth_module/view/dashboard_view.dart';
import 'package:ipotec/auth_module/view/login_view.dart';
import 'package:ipotec/calc_module/view/calc_landing_view.dart';
import 'package:ipotec/calc_module/view/lumpsum_calculator/lumpsum_calculator_result.dart';
import 'package:ipotec/calc_module/view/lumpsum_calculator/lumpsum_calculator_view.dart';
import 'package:ipotec/calc_module/view/sip_calculator/sip_calculator_result.dart';
import 'package:ipotec/calc_module/view/sip_calculator/sip_calculator_view.dart';
import 'package:ipotec/calc_module/view/sip_calculator/sip_plan_calculator_view.dart';
import 'package:ipotec/calc_module/view/sip_top_up_calculator/sip_top_up_calculator_view.dart';
import 'package:ipotec/calc_module/view/sip_top_up_calculator/sip_top_up_calculator_result.dart';
import 'package:ipotec/calc_module/view/stp_calculator/stp_calculator_result.dart';
import 'package:ipotec/calc_module/view/stp_calculator/stp_calculator_view.dart';
import 'package:ipotec/calc_module/view/swp_calculator/swp_calculator_result.dart';
import 'package:ipotec/calc_module/view/swp_calculator/swp_calculator_view.dart';
import 'package:ipotec/ifsc_module/view/ifsc_details.dart';
import 'package:ipotec/ifsc_module/view/ifsc_finder.dart';
import 'package:ipotec/ipo_module/view/bottom/blogs_main_view.dart';
import 'package:ipotec/ipo_module/view/bottom/ipo_gmp_view.dart';
import 'package:ipotec/ipo_module/view/drawer/ipo_performance_view.dart';
import 'package:ipotec/ipo_module/view/drawer/least_successful_ipo_view.dart';
import 'package:ipotec/ipo_module/view/drawer/mainboard_calendar_view.dart';
import 'package:ipotec/ipo_module/view/drawer/mainboard_ipo_subs_view.dart';
import 'package:ipotec/ipo_module/view/drawer/most_successful_ipo_view.dart';
import 'package:ipotec/ipo_module/view/drawer/sme_calendar_view.dart';
import 'package:ipotec/ipo_module/view/drawer/sme_ipo_subs_view.dart';
import 'package:ipotec/ipo_module/view/ipo_details_view.dart';
import 'package:ipotec/ipo_module/view/others/no_internet.dart';
import 'package:ipotec/ipo_module/view/others/policy_view.dart';
import 'package:ipotec/ipo_module/view/bottom/mainboard_ipo_view.dart';
import 'package:ipotec/ipo_module/view/landing_view.dart';
import 'package:ipotec/ipo_module/view/bottom/sme_ipo_view.dart';
import 'package:ipotec/ipo_module/view/others/web_view.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
final GoRouter goRouterConfig = GoRouter(
  initialLocation: GoPaths.dashboard,
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
      path: GoPaths.login,
      name: GoPaths.login,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final type = extras['type'];
        return LoginView(callType: type);
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dashboard,
      name: GoPaths.dashboard,
      builder: (context, state) {
        return const DashboardView();
      },
    ),

    // GoRoute(
    //   parentNavigatorKey: rootNavigatorKey,
    //   path: GoPaths.eventsView,
    //   name: GoPaths.eventsView,
    //   builder: (context, state) {
    //     return const EventsView();
    //   },
    // ),

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

    // ------------------   Extras Page Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.performance,
      name: GoPaths.performance,
      builder: (context, state) {
        return const IpoPerformanceView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.mostSuccessfulIpo,
      name: GoPaths.mostSuccessfulIpo,
      builder: (context, state) {
        return const MostSuccessfulIpoView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.leastSuccessfulIpo,
      name: GoPaths.leastSuccessfulIpo,
      builder: (context, state) {
        return const LeastSuccessfulIpoView();
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
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.ipoDetails,
      name: GoPaths.ipoDetails,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final slug = extras['slug'];
        final name = extras['name'];
        return IpoDetailsView(slug: slug, name: name);
      },
    ),

    // ------------------   Calculator Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.calcLanding,
      name: GoPaths.calcLanding,
      builder: (context, state) {
        return const CalcLandingView();
      },
    ),

    // ------------------   SIP Calculator Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.sipTopupCalculatorView,
      name: GoPaths.sipTopupCalculatorView,
      builder: (context, state) {
        return const SipTopUpCalculator();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.sipTopupCalculatorResult,
      name: GoPaths.sipTopupCalculatorResult,
      builder: (context, state) {
        return const SipTopUpCalculatorResult();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.sipPlanCalculatorView,
      name: GoPaths.sipPlanCalculatorView,
      builder: (context, state) {
        return const SipPlanCalculator();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.sipCalculatorView,
      name: GoPaths.sipCalculatorView,
      builder: (context, state) {
        return const SipCalculatorView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.sipCalculatorResult,
      name: GoPaths.sipCalculatorResult,
      builder: (context, state) {
        return const SipCalculatorResult();
      },
    ),

    // ------------------   Lumpsum Calculator Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.lumpSumCalculatorView,
      name: GoPaths.lumpSumCalculatorView,
      builder: (context, state) {
        return const LumpsumCalculatorView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.lumpSumCalculatorResult,
      name: GoPaths.lumpSumCalculatorResult,
      builder: (context, state) {
        return const LumpsumCalculatorResult();
      },
    ),

    // ------------------   SWP Calculator Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.swpCalculatorView,
      name: GoPaths.swpCalculatorView,
      builder: (context, state) {
        return const SwpCalculatorView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.swpCalculatorResult,
      name: GoPaths.swpCalculatorResult,
      builder: (context, state) {
        return const SwpCalculatorResult();
      },
    ),

    // ------------------   STP Calculator Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.stpCalculatorView,
      name: GoPaths.stpCalculatorView,
      builder: (context, state) {
        return const StpCalculatorView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.stpCalculatorResult,
      name: GoPaths.stpCalculatorResult,
      builder: (context, state) {
        return const StpCalculatorResult();
      },
    ),

    // ------------------   IFSC CODE MODULE Routes   ---------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.ifscFinder,
      name: GoPaths.ifscFinder,
      builder: (context, state) {
        return const IfscFinder();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.ifscDetails,
      name: GoPaths.ifscDetails,
      builder: (context, state) {
        return const IfscDetails();
      },
    ),
  ],
);
