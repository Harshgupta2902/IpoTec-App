import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/ipo_module/components/ipo_gmp_card.dart';
import 'package:ipotec/ipo_module/controller/drawer/ipo_gmp_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _ipoGmpController = Get.put(IpoGmpController());

class IpoGmpView extends StatelessWidget {
  const IpoGmpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CoreAppBar(
        title: "Ipo GMP",
        centerTitle: false,
        showBackButton: false,
        showActions: false,
      ),
      body: _ipoGmpController.obx(
        (state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12),
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
      ),
    );
  }
}
