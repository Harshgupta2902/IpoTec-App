import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/auth_controller.dart';
import 'package:ipotec/dashboard_module/controller/default_controller.dart';
import 'package:ipotec/dashboard_module/view/policy_view.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _authController = Get.put(AuthController());
final _defaultController = Get.put(DefaultApiController());

enum CallApiType { gmp, subs, forms, main, sme, buyback, blogs, none }

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.callType});
  final CallApiType callType;
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 400),
      () => _authController.googleSignIn(isPop: true, type: widget.callType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => MyNavigator.pop(),
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            Image.asset(
              AssetPath.loginLogo,
              height: MediaQuery.of(context).size.height * 0.27,
            ),
            const SizedBox(height: 26),
            Text(
              "All About Ipo",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Information",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.circle, color: Colors.grey, size: 12),
                ),
                Text(
                  "News",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.circle, color: Colors.grey, size: 12),
                ),
                Text(
                  "Alerts",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Sign up or Log In Now to get Realtime Alerts and access additional Information of GMP, Live Subscription.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.oil,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                side: const BorderSide(color: Colors.grey),
              ),
              onPressed: () {
                if (_authController.isLoggingIn.value == false) {
                  _authController.googleSignIn(isPop: true, type: widget.callType);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetPath.googleSvg,
                    height: 22,
                    width: 22,
                  ),
                  const SizedBox(width: 16),
                  const Text("Continue with Google"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: "I Accept ",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: "Terms & Conditions",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        MyNavigator.pushNamed(
                          GoPaths.policyView,
                          extra: {
                            'type': PolicyType.terms,
                            'policy': _defaultController.state?.terms,
                          },
                        );
                      },
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: " and ",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        MyNavigator.pushNamed(
                          GoPaths.policyView,
                          extra: {
                            'type': PolicyType.privacy,
                            'policy': _defaultController.state?.privacy,
                          },
                        );
                      },
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight - 20),
          Image.asset(
            AssetPath.loginLogo,
            height: MediaQuery.of(context).size.height * 0.27,
          ),
          const SizedBox(height: 26),
          Text(
            "All About Ipo",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Information",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.circle, color: Colors.grey, size: 12),
              ),
              Text(
                "News",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.circle, color: Colors.grey, size: 12),
              ),
              Text(
                "Alerts",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Sign up or Log In Now to get Realtime Alerts and access additional Information of GMP, Live Subscription.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.oil,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              side: const BorderSide(color: Colors.grey),
            ),
            onPressed: () {
              if (_authController.isLoggingIn.value == false) {
                _authController.googleSignIn(isPop: true, type: CallApiType.gmp);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetPath.googleSvg,
                  height: 22,
                  width: 22,
                ),
                const SizedBox(width: 16),
                const Text("Continue with Google"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: "I Accept ",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: "Terms & Conditions",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      MyNavigator.pushNamed(
                        GoPaths.policyView,
                        extra: {
                          'type': PolicyType.terms,
                          'policy': _defaultController.state?.terms,
                        },
                      );
                    },
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.primaryColor, fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: " and ",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: "Privacy Policy",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      MyNavigator.pushNamed(
                        GoPaths.policyView,
                        extra: {
                          'type': PolicyType.privacy,
                          'policy': _defaultController.state?.privacy,
                        },
                      );
                    },
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.primaryColor, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
