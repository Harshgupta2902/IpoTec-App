import 'package:flutter/material.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key, required this.child});

  final Widget child;

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landing View"),
      ),
      body: widget.child,
    );
  }
}
