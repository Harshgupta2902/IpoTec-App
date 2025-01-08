import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

class SipCalculatorResult extends StatefulWidget {
  const SipCalculatorResult({super.key});

  @override
  State<SipCalculatorResult> createState() => _SipCalculatorResultState();
}

class _SipCalculatorResultState extends State<SipCalculatorResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        showBackButton: true,
        centerTitle: false,
        title: "SIP Calculator Result",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Slider(
              value: 0,
              onChanged: (newValue) {
                setState(() {
                  // value = (newValue / 100).round() * 100;
                });
              },
              min: 0,
              max: 1000000,
            ),
          ],
        ),
      ),
    );
  }
}
