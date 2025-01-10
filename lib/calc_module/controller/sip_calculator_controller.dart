import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/functions/sip_functions.dart';
import 'package:ipotec/utilities/constants/functions.dart';

class SIPCalculatorController extends GetxController with StateMixin<CoreSIPModel> {
  calculateSIP({
    required double sipAmount,
    required int tenure,
    required double returnRate,
  }) {
    logger.i("SIPCalculatorController => calculateSIP > start");
    change(null, status: RxStatus.loading());

    logger.i("SIPCalculatorController => calculateSIP > start ");

    final reports = performSIPFunctions(
      sipAmount: sipAmount,
      depositFrequency: 1,
      tenure: tenure,
      tenureType: 12,
      returnRate: returnRate,
      compoundFrequency: 1,
    );

    change(reports, status: RxStatus.success());
    logger.i("SIPCalculatorController => calculateSIP > end");
  }

  resetController() {
    change(null, status: RxStatus.success());
  }

  // calculateSIPPlan({
  //   required double corpusAmount,
  //   required int tenure,
  //   required double returnRate,
  // }) {
  //   logger.i("SIPCalculatorController => calculateSIPPlan > start");
  //   change(null, status: RxStatus.loading());
  //
  //   logger.i("SIPCalculatorController => calculateSIPPlan > start ");
  //
  //   final sipAmount = performSipCalculateAmount(
  //     corpusAmount: corpusAmount,
  //     rate: returnRate,
  //     tenureInYears: tenure.toDouble(),
  //   );
  //
  //   final reports = performSIPFunctions(
  //     sipAmount: sipAmount,
  //     depositFrequency: 1,
  //     tenure: tenure,
  //     tenureType: 12,
  //     returnRate: returnRate,
  //     compoundFrequency: 1,
  //   );
  //
  //   change(reports, status: RxStatus.success());
  //   logger.i("SIPCalculatorController => calculateSIPPlan > end");
  // }
}
