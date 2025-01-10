import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class SipTopUpCalculator extends StatefulWidget {
  const SipTopUpCalculator({super.key});

  @override
  State<SipTopUpCalculator> createState() => _SipTopUpCalculatorState();
}

class _SipTopUpCalculatorState extends State<SipTopUpCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CoreAppBar(
        showBackButton: true,
        centerTitle: false,
        title: "SIP Top Up Calculator",
      ),
    );
  }
}
