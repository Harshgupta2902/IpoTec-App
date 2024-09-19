import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/mainboard_ipo_details_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

final _mainBoardIpoDetailsController = Get.put(MainBoardDetailsController());

class MainboardIpoDetailsView extends StatefulWidget {
  const MainboardIpoDetailsView({super.key, required this.slug});
  final String slug;

  @override
  State<MainboardIpoDetailsView> createState() => _MainboardIpoDetailsViewState();
}

class _MainboardIpoDetailsViewState extends State<MainboardIpoDetailsView> {
  @override
  void initState() {
    _mainBoardIpoDetailsController.getMainboardDetails(slug: widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoreAppBar(
        title: "",
      ),
    );
  }
}
