import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/auth_controller.dart';
import 'package:ipotec/auth_module/view/login_view.dart';
import 'package:ipotec/dashboard_module/components/ipo_gmp_card.dart';
import 'package:ipotec/dashboard_module/controller/drawer/ipo_gmp_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/firebase/core_prefs.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _ipoGmpController = Get.put(IpoGmpController());
final _authController = Get.put(AuthController());

class IpoGmpView extends StatefulWidget {
  const IpoGmpView({super.key});

  @override
  State<IpoGmpView> createState() => _IpoGmpViewState();
}

class _IpoGmpViewState extends State<IpoGmpView> {
  @override
  void initState() {
    super.initState();
    if (isLoggedIn() == false) {
      Future.delayed(
        const Duration(milliseconds: 400),
        () => _authController.googleSignIn(isPop: false, type: CallApiType.gmp),
      );
    }
    _ipoGmpController.getGmpData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLoggedIn() ? AppColors.backgroundColor : AppColors.white,
      appBar: const CoreAppBar(
        title: "Ipo GMP",
        centerTitle: false,
        showBackButton: false,
        showActions: false,
      ),
      body: isLoggedIn()
          ? _ipoGmpController.obx(
              (state) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: state?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final gmpData = state?.data?[index];
                    return IpoGmpCard(state: gmpData);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                );
              },
              onError: (error) => TryAgainWidget(
                onTap: () => _ipoGmpController.getGmpData(),
              ),
            )
          : const LoginCard(),
    );
  }
}
