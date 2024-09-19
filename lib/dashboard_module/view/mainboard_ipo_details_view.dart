import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';


class MainboardIpoDetailsView extends StatefulWidget {
  const MainboardIpoDetailsView({super.key, required this.slug});
  final String slug;

  @override
  State<MainboardIpoDetailsView> createState() => _MainboardIpoDetailsViewState();
}

class _MainboardIpoDetailsViewState extends State<MainboardIpoDetailsView> {
  @override
  void initState() {

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
