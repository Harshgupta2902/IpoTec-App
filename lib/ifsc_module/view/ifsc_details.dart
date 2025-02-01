import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

class IfscDetails extends StatefulWidget {
  const IfscDetails({super.key});

  @override
  State<IfscDetails> createState() => _IfscDetailsState();
}

class _IfscDetailsState extends State<IfscDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoreAppBar(
        showBackButton: true,
        title: "IFSC Code Detilas",
      ),
      body: Column(
        children: [
          Text("IFSC Detilas"),
        ],
      ),
    );
  }
}
