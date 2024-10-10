import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/ipo_forms_card.dart';
import 'package:ipotec/dashboard_module/components/ipo_gmp_card.dart';
import 'package:ipotec/dashboard_module/controller/ipo_forms_controller.dart';
import 'package:ipotec/dashboard_module/controller/ipo_gmp_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

final _ipoGmpController = Get.put(IpoGmpController());

class IpoGmpView extends StatefulWidget {
  const IpoGmpView({super.key});

  @override
  State<IpoGmpView> createState() => _IpoGmpViewState();
}

class _IpoGmpViewState extends State<IpoGmpView> {
  @override
  void initState() {
    _ipoGmpController.getGmpData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "Ipo GMP",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _ipoGmpController.obx(
        (state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: state?.gmp?.length ?? 0,
            itemBuilder: (context, index) {
              final gmpData = state?.gmp?[index];
              return IpoGmpCard(state: gmpData);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
        },
      ),
    );
  }
}
