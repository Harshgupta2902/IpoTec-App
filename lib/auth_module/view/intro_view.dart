import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  final List<KeyValuePairModel> introScreens = [
    KeyValuePairModel(
      key: "Welcome to IPO Insights",
      value: "Unlock the potential of IPOs and mutual funds with cutting-edge insights.",
      extra: AssetPath.mainIntro,
    ),
    KeyValuePairModel(
      key: "Your Guide to Markets",
      value: "Simplify your decisions with timely notifications and expert-curated details.",
      extra: AssetPath.ipoIntro,
    ),
    KeyValuePairModel(
      key: "Stay Informed, Stay Smart",
      value: "Join our community to track the latest trends and make informed financial choices.",
      extra: AssetPath.mfIntro,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < introScreens.length - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        timer.cancel();
        MyNavigator.pushNamed(GoPaths.dashboard);
        setIntro(false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      introScreens.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        // Animation duration
                        curve: Curves.easeInOut,
                        // Animation curve
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 60.0 : 50.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: _currentPage == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  // Skip button
                  TextButton(
                    onPressed: () {
                      MyNavigator.pushNamed(GoPaths.dashboard);
                      setIntro(false);
                    },
                    child: Text(
                      'SKIP',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: introScreens.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(introScreens[index].extra),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      Text(
                        introScreens[index].key,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          introScreens[index].value,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: kBottomNavigationBarHeight),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
