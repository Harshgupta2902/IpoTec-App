import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/sip_calculator_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_text_form_fields.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _sipCalculatorController = Get.put(SIPCalculatorController());

class SipCalculatorView extends StatefulWidget {
  const SipCalculatorView({super.key});

  @override
  State<SipCalculatorView> createState() => _SipCalculatorViewState();
}

class _SipCalculatorViewState extends State<SipCalculatorView> {
  final TextEditingController _invTextController = TextEditingController();
  final TextEditingController _returnsTextController = TextEditingController();
  final TextEditingController _tenureTextController = TextEditingController();

  double invValue = 25000;
  double retValue = 12;
  double tenureValue = 10;

  @override
  void initState() {
    super.initState();
    _invTextController.text = invValue.toStringAsFixed(0);
    _returnsTextController.text = retValue.toStringAsFixed(0);
    _tenureTextController.text = tenureValue.toStringAsFixed(0);
  }

  Future<void> _updateInv(String inputValue) async {
    if (inputValue.isEmpty) {
      setState(() {
        invValue = 1000;
      });
      _invTextController.text = "1000";
      return;
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
        retValue = 1;
      });
      _returnsTextController.text = "1";
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

  Future<void> _updateSliderForTenure(String inputValue) async {
    if (inputValue.isEmpty) {
      setState(() {
        tenureValue = 1;
      });
      _tenureTextController.text = "1";
      return;
    }

    final double? newValue = double.tryParse(inputValue);
    if (newValue != null && newValue >= 1 && newValue <= 40) {
      setState(() {
        tenureValue = newValue;
      });
    }
  }

  Future<void> _updateTextFieldForTenure(double newValue) async {
    setState(() {
      tenureValue = newValue;
    });
    _tenureTextController.text = tenureValue.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CoreAppBar(
          showBackButton: true,
          centerTitle: false,
          title: "SIP Calculator",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _invTextController,
                hintText: "Monthly Investment",
                keyboardType: TextInputType.number,
                inputFormatter: [
                  LengthLimitingTextInputFormatter(7),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validationMode: AutovalidateMode.onUserInteraction,
                validator: (invValue) {
                  if (invValue == "" || invValue == null) {
                    return "Please enter amount";
                  } else if (invValue == '0') {
                    return "Please enter valid amount";
                  } else {
                    return null;
                  }
                },
                onChanged: (newValue) async {
                  await _updateInv(newValue);
                },
              ),
            ],
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: () => FocusScope.of(context).unfocus(),
    //   child: Scaffold(
    //     appBar: const CoreAppBar(
    //       showBackButton: true,
    //       centerTitle: false,
    //       title: "SIP Calculator",
    //     ),
    //     body: Column(
    //       children: [
    //         // Monthy Investments
    //         const SizedBox(height: 12),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 "Monthly Investment",
    //                 style: Theme.of(context).textTheme.titleSmall,
    //               ),
    //               SizedBox(
    //                 height: 30,
    //                 width: MediaQuery.of(context).size.width * 0.3,
    //                 child: GrowTextField(
    //                   controller: _invTextController,
    //                   hintText: "$invValue",
    //                   keyboardType: TextInputType.number,
    //                   inputFormatter: [
    //                     LengthLimitingTextInputFormatter(7),
    //                     FilteringTextInputFormatter.digitsOnly,
    //                   ],
    //                   prefix: Padding(
    //                     padding: const EdgeInsets.only(top: 3),
    //                     child: Text(
    //                       "  ₹",
    //                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
    //                             color: Colors.green,
    //                           ),
    //                     ),
    //                   ),
    //                   textColor: Colors.green,
    //                   fillColor: Colors.green.withOpacity(0.1),
    //                   validationMode: AutovalidateMode.onUserInteraction,
    //                   onChanged: (newValue) async {
    //                     await _updateSliderForInv(newValue);
    //                   },
    //                   validator: (invValue) {
    //                     if (invValue == "" || invValue == null) {
    //                       return "Please enter amount";
    //                     } else if (invValue == '0') {
    //                       return "Please enter valid amount";
    //                     } else {
    //                       return null;
    //                     }
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Slider(
    //           value: invValue,
    //           onChanged: (newValue) async {
    //             await _updateTextFieldForInv((newValue / 100).round() * 100);
    //           },
    //           min: 0,
    //           max: 1000000,
    //         ),
    //         const SizedBox(height: 8),
    //
    //         // Monthly Investments
    //         const SizedBox(height: 12),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 "Expected Returns",
    //                 style: Theme.of(context).textTheme.titleSmall,
    //               ),
    //               SizedBox(
    //                 height: 30,
    //                 width: MediaQuery.of(context).size.width * 0.22,
    //                 child: GrowTextField(
    //                   controller: _returnsTextController,
    //                   hintText: "$retValue",
    //                   keyboardType: TextInputType.number,
    //                   inputFormatter: [
    //                     LengthLimitingTextInputFormatter(5),
    //                     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
    //                   ],
    //                   suffix: Padding(
    //                     padding: const EdgeInsets.only(top: 3),
    //                     child: Text(
    //                       "%",
    //                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
    //                             color: Colors.green,
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                     ),
    //                   ),
    //                   textColor: Colors.green,
    //                   fillColor: Colors.green.withOpacity(0.1),
    //                   validationMode: AutovalidateMode.onUserInteraction,
    //                   onChanged: (newValue) async {
    //                     await _updateSliderForRet(newValue);
    //                   },
    //                   validator: (value) {
    //                     if (value == "" || value == null) {
    //                       return "Please enter a valid percentage";
    //                     } else if (double.tryParse(value) == null ||
    //                         double.parse(value) < 1 ||
    //                         double.parse(value) > 30) {
    //                       return "Please enter a percentage between 1 and 30";
    //                     } else {
    //                       return null;
    //                     }
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Slider(
    //           value: retValue,
    //           onChanged: (newValue) async {
    //             await _updateTextFieldForRet(newValue);
    //           },
    //           min: 1,
    //           max: 30,
    //         ),
    //         const SizedBox(height: 20),
    //
    //         // Tenure
    //         const SizedBox(height: 12),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 "Time Period",
    //                 style: Theme.of(context).textTheme.titleSmall,
    //               ),
    //               SizedBox(
    //                 height: 30,
    //                 width: MediaQuery.of(context).size.width * 0.22,
    //                 child: GrowTextField(
    //                   controller: _tenureTextController,
    //                   hintText: "${tenureValue.round()}",
    //                   keyboardType: TextInputType.number,
    //                   inputFormatter: [
    //                     LengthLimitingTextInputFormatter(5),
    //                     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
    //                   ],
    //                   suffix: Padding(
    //                     padding: const EdgeInsets.only(top: 3),
    //                     child: Text(
    //                       "Yr",
    //                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
    //                             color: Colors.green,
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                     ),
    //                   ),
    //                   textColor: Colors.green,
    //                   fillColor: Colors.green.withOpacity(0.1),
    //                   validationMode: AutovalidateMode.onUserInteraction,
    //                   onChanged: (newValue) async {
    //                     await _updateSliderForTenure(newValue);
    //                   },
    //                   validator: (value) {
    //                     if (value == "" || value == null) {
    //                       return "Please enter year";
    //                     } else if (double.tryParse(value) == null ||
    //                         double.parse(value) < 1 ||
    //                         double.parse(value) > 40) {
    //                       return "Please enter year between 1 and 40";
    //                     } else {
    //                       return null;
    //                     }
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Slider(
    //           value: tenureValue,
    //           onChanged: (newValue) async {
    //             await _updateTextFieldForTenure(newValue);
    //           },
    //           min: 1,
    //           max: 40,
    //         ),
    //         const SizedBox(height: 20),
    //
    //         ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //               minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 40),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(8),
    //               )),
    //           onPressed: () async {
    //             await _sipCalculatorController.calculateSIP(
    //               sipAmount: double.tryParse(_invTextController.text) ?? 0,
    //               returnRate: double.tryParse(_returnsTextController.text) ?? 0,
    //               tenure: int.parse(_tenureTextController.text),
    //             );
    //             MyNavigator.pushNamed(GoPaths.sipCalculatorResult);
    //           },
    //           child: const Text("Calculate"),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
