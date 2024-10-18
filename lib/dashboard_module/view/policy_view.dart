import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

enum PolicyType { terms, privacy }

class PolicyView extends StatelessWidget {
  const PolicyView({
    super.key,
    required this.type,
    required this.policy,
  });
  final PolicyType type;
  final String policy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoreAppBar(
        showBackButton: true,
        title: type == PolicyType.privacy ? "Privacy Policy" : "Terms & Conditions",
        showActions: false,
        centerTitle: false,
      ),
      body: SingleChildScrollView(child: Html(data: policy)),
    );
  }
}
