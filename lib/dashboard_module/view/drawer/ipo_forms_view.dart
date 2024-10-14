import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/ipo_forms_card.dart';
import 'package:ipotec/dashboard_module/controller/drawer/ipo_forms_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';

final _ipoFormsController = Get.put(IpoFormsController());

class IpoFormsView extends StatefulWidget {
  const IpoFormsView({super.key});

  @override
  State<IpoFormsView> createState() => _IpoFormsViewState();
}

class _IpoFormsViewState extends State<IpoFormsView> {
  @override
  void initState() {
    _ipoFormsController.getFormsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "Ipo Forms",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _ipoFormsController.obx(
        (state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: state?.forms?.length ?? 0,
            itemBuilder: (context, index) {
              final formData = state?.forms?[index];
              return IpoFormsCard(state: formData);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
        },
        onError: (error) => TryAgainWidget(
          onTap: () => _ipoFormsController.getFormsData(),
        ),
      ),
    );
  }
}
