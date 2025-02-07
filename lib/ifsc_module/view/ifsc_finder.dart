import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

class IfscFinder extends StatefulWidget {
  const IfscFinder({super.key});

  @override
  State<IfscFinder> createState() => _IfscFinderState();
}

class _IfscFinderState extends State<IfscFinder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CoreAppBar(
        showBackButton: true,
        title: "IFSC Code Finder",
        centerTitle: false,
      ),
      body: Column(
        children: [
          Text("IFSC Code"),
        ],
      ),
    );
  }
}
