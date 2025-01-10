import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/components/dashboard/dashboard_tape.dart';
import 'package:ipotec/auth_module/controller/auth_controller.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/common/scaffold_messenger.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _authController = Get.put(AuthController());

class CalcLandingView extends StatefulWidget {
  const CalcLandingView({super.key});

  @override
  State<CalcLandingView> createState() => _CalcLandingViewState();
}

class _CalcLandingViewState extends State<CalcLandingView> {
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

  int activeIndex = 0;
  final controller = CarouselSliderController();
  final List<KeyValuePairModel> banner = [
    KeyValuePairModel(key: AssetPath.sipBanner, value: GoPaths.sipCalculatorView),
    KeyValuePairModel(key: AssetPath.swpBanner, value: GoPaths.swpCalculatorView),
    KeyValuePairModel(key: AssetPath.stpBanner, value: GoPaths.stpCalculatorView),
    KeyValuePairModel(key: AssetPath.lumpBanner, value: GoPaths.lumpSumCalculatorView),
  ];

  final List<KeyValuePairModel> sipCalc = [
    KeyValuePairModel(
      key: "SIP\nCalculator",
      value: AssetPath.sipCalc,
      extra: GoPaths.sipCalculatorView,
    ),
    KeyValuePairModel(
      key: "LumpSum\nCalculator",
      value: AssetPath.lumpCalc,
      extra: GoPaths.lumpSumCalculatorView,
    ),
    KeyValuePairModel(
      key: "SIP Plan\nCalculator",
      value: AssetPath.sipPlanCalc,
      extra: GoPaths.sipPlanCalculatorView,
    ),
    KeyValuePairModel(
      key: "SIP TopUp\nCalculator",
      value: AssetPath.sipTopUpCalc,
      extra: GoPaths.sipTopupCalculatorView,
    ),
  ];

  final List<KeyValuePairModel> mfCalc = [
    KeyValuePairModel(
      key: "SWP\nCalculator",
      value: AssetPath.swpCalc,
      extra: GoPaths.swpCalculatorView,
    ),
    KeyValuePairModel(
      key: "STP\nCalculator",
      value: AssetPath.stpCalc,
      extra: GoPaths.stpCalculatorView,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              backgroundColor: AppColors.primaryColor,
              automaticallyImplyLeading: false,
              expandedHeight: 100,
              collapsedHeight: 100,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Text(
                          getGreetMsg(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 140),
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: banner.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () => MyNavigator.pushNamed(banner[index].value),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(banner[index].key),
                      ),
                    ),
                    width: double.infinity,
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2 / 1,
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
            _calcBody(title: "SIP Calculator", calcData: sipCalc),
            const SizedBox(height: 20),
            _calcBody(title: "Mutual Fund Calculators", calcData: mfCalc),
          ],
        ),
      ),
    );
  }

  _calcBody({required String title, required List<KeyValuePairModel> calcData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 80,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: calcData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (calcData[index].extra == null || calcData[index].extra == "") {
                    messageScaffold(
                      content: "${calcData[index].key.replaceAll("\n", " ")} Coming Soon",
                      messageScaffoldType: MessageScaffoldType.information,
                    );
                    return;
                  }
                  MyNavigator.pushNamed(calcData[index].extra);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: AppBoxDecoration.getBoxDecoration(
                    border: Border.all(
                      color: AppColors.silverChalice30,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        calcData[index].key,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Image.asset(
                        calcData[index].value,
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
