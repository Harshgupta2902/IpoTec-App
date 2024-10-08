import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/ipo_forms_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

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
      appBar: CoreAppBar(
        title: "Ipo Forms",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _ipoFormsController.obx(
        (state) {
          return ListView.builder(
            itemCount: state?.forms?.length ?? 0,
            itemBuilder: (context, index) {
              return Text("${state?.forms?[index].companyName}");
            },
          );
        },
      ),
    );
  }
}
