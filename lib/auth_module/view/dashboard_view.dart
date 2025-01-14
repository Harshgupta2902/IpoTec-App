import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ipotec/auth_module/components/dashboard/dashboard_tape.dart';
import 'package:ipotec/auth_module/components/dashboard/today_events_view.dart';
import 'package:ipotec/auth_module/components/dashboard/today_mf_view.dart';
import 'package:ipotec/auth_module/components/dashboard/today_stock_view.dart';
import 'package:ipotec/auth_module/components/dashboard/trending_ipo_view.dart';
import 'package:ipotec/auth_module/controller/auth_controller.dart';
import 'package:ipotec/auth_module/controller/mmi_controller.dart';
import 'package:ipotec/utilities/common/core_update_handler.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/common/scaffold_messenger.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/firebase/analytics_service.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _authController = Get.put(AuthController());
final _mmiController = Get.put(MmiController());

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    apiCalls();
  }

  void apiCalls() async {
    _mmiController.getMmiData();
    if (isLoggedIn()) {
      final uid = getUuid();
      _authController.fetchUserData(uid);
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      }
    }
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        return checkUpdate();
      },
    );
    final uid = getUuid();
    FirebaseAnalyticsService().init(uid);
  }

  void checkUpdate() async {
    await appUpdateCheck(context: context);
  }

  int activeIndex = 0;
  final controller = CarouselSliderController();
  final List<KeyValuePairModel> banner = [
    KeyValuePairModel(key: AssetPath.calcBanner, value: GoPaths.calcLanding),
    KeyValuePairModel(key: AssetPath.mfBanner, value: GoPaths.swpCalculatorView),
    KeyValuePairModel(key: AssetPath.ifscBanner, value: GoPaths.stpCalculatorView),
  ];

  String getGreetMsg() {
    var name = _authController.state?.displayName ?? "";

    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Hi, Good Morning $name";
    } else if (hour >= 12 && hour < 17) {
      return "Hi, Good Afternoon $name";
    } else if (hour >= 17 && hour < 21) {
      return "Hi, Good Evening $name";
    } else {
      return "Hi, Good Night $name";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              backgroundColor: AppColors.onyx,
              automaticallyImplyLeading: false,
              expandedHeight: 130,
              collapsedHeight: 130,
              pinned: true,
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 6),
                        child: Text(
                          getGreetMsg(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      _mmiController.obx((state) {
                        String marketCondition = "";
                        Color marketColor = Colors.green;

                        if (state?.data?.currentValue != null) {
                          if ((state?.data?.currentValue ?? 0) < 30) {
                            marketCondition = "Extreme Fear";
                            marketColor = Colors.green;
                          } else if ((state?.data?.currentValue ?? 0) >= 30 &&
                              (state?.data?.currentValue ?? 0) < 50) {
                            marketCondition = "Fear";
                            marketColor = Colors.orange;
                          } else if ((state?.data?.currentValue ?? 0) >= 50 &&
                              (state?.data?.currentValue ?? 0) < 70) {
                            marketCondition = "Greed";
                            marketColor = Colors.deepOrange;
                          } else {
                            marketCondition = "Extreme Greed";
                            marketColor = Colors.red;
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                          child: RichText(
                            text: TextSpan(
                              text: "The Market is in ",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                              children: [
                                TextSpan(
                                  text: marketCondition,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: marketColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                TextSpan(
                                  text: " zone",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, onLoading: const SizedBox.shrink()),
                      const DashboardTape(
                        textColor: AppColors.white,
                        isBlur: true,
                      ),
                    ],
                  ),
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 140),
              CarouselSlider.builder(
                carouselController: controller,
                itemCount: banner.length,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      if (banner[index].value == GoPaths.calcLanding) {
                        MyNavigator.pushNamed(banner[index].value);
                      } else {
                        messageScaffold(
                          content: "Coming Soon",
                          messageScaffoldType: MessageScaffoldType.information,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(banner[index].key),
                        ),
                      ),
                      width: double.infinity,
                      height: 156,
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: true,
                  disableCenter: true,
                  pauseAutoPlayOnTouch: false,
                  clipBehavior: Clip.hardEdge,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  onPageChanged: (index, reason) => setState(() => activeIndex = index),
                  pageSnapping: false,
                  scrollDirection: Axis.horizontal,
                  scrollPhysics: const BouncingScrollPhysics(),
                ),
              ),
              const TrendingIpoView(),
              const SizedBox(height: 20),
              const TodayStockView(),
              const SizedBox(height: 20),
              const TodayMfView(),
              const SizedBox(height: 20),
              const NewsEventsView(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
