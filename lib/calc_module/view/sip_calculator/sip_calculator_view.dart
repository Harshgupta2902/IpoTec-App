import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_text_form_fields.dart';

class SipCalculatorView extends StatefulWidget {
  const SipCalculatorView({super.key});

  @override
  State<SipCalculatorView> createState() => _SipCalculatorViewState();
}

class _SipCalculatorViewState extends State<SipCalculatorView> {
  final TextEditingController _invTextController = TextEditingController();
  final TextEditingController _returnsTextController = TextEditingController();

  double invValue = 25000;
  double retValue = 13;

  @override
  void initState() {
    super.initState();
    _invTextController.text = invValue.toStringAsFixed(0);
  }

  Future<void> _updateSliderForInv(String inputValue) async {
    if (inputValue.isEmpty) {
      setState(() {
        invValue = 1000;
      });
      _invTextController.text = "1000";
      return;
    }

    if (inputValue.isEmpty) return;
    final double? newValue = double.tryParse(inputValue);
    if (newValue != null && newValue >= 0 && newValue <= 1000000) {
      setState(() {
        invValue = newValue;
      });
    }
  }

  Future<void> _updateTextFieldForInv(double newValue) async {
    setState(() {
      invValue = newValue;
    });
    _invTextController.text = invValue.toStringAsFixed(0);
  }

  Future<void> _updateSliderForRet(String inputValue) async {
    if (inputValue.isEmpty) {
      setState(() {
        retValue = 1; // Default percentage when cleared
      });
      _returnsTextController.text = "1.0";
      return;
    }

    final double? newValue = double.tryParse(inputValue);
    if (newValue != null && newValue >= 1 && newValue <= 30) {
      setState(() {
        retValue = newValue;
      });
    }
  }

  Future<void> _updateTextFieldForRet(double newValue) async {
    setState(() {
      retValue = newValue;
    });
    _returnsTextController.text = retValue.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CoreAppBar(
          showBackButton: true,
          centerTitle: false,
          title: "SIP Calculator",
        ),
        body: Column(
          children: [
            // Monthy Investments
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monthly Investment",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextFormField(
                      controller: _invTextController,
                      hintText: "$invValue",
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      prefix: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          "  ₹",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.green,
                              ),
                        ),
                      ),
                      textColor: Colors.green,
                      fillColor: Colors.green.withOpacity(0.1),
                      validationMode: AutovalidateMode.onUserInteraction,
                      onChanged: (newValue) async {
                        await _updateSliderForInv(newValue);
                      },
                      validator: (invValue) {
                        if (invValue == "" || invValue == null) {
                          return "Please enter amount";
                        } else if (invValue == '0') {
                          return "Please enter valid amount";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Slider(
              value: invValue,
              onChanged: (newValue) async {
                await _updateTextFieldForInv((newValue / 100).round() * 100);
              },
              min: 0,
              max: 1000000,
            ),
            const SizedBox(height: 8),

            // Monthly Investments
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expected Returns",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextFormField(
                      controller: _returnsTextController,
                      hintText: "$retValue",
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(5),
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      suffix: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          "%",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.green,
                              ),
                        ),
                      ),
                      textColor: Colors.green,
                      fillColor: Colors.green.withOpacity(0.1),
                      validationMode: AutovalidateMode.onUserInteraction,
                      onChanged: (newValue) async {
                        await _updateSliderForRet(newValue);
                      },
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter a valid percentage";
                        } else if (double.tryParse(value) == null ||
                            double.parse(value) < 1 ||
                            double.parse(value) > 30) {
                          return "Please enter a percentage between 1 and 30";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Slider(
              value: retValue,
              onChanged: (newValue) async {
                await _updateTextFieldForRet(newValue);
              },
              min: 1,
              max: 30,
              divisions: 290,
              label: "${retValue.toStringAsFixed(1)}%",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
