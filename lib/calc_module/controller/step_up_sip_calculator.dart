import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/functions/step_up_functions.dart';
import 'package:ipotec/utilities/constants/functions.dart';

class StepUpSIPController extends GetxController with StateMixin<CoreStepUpSIPModel> {
  calculateStepUP({
    required double sipAmount,
    required int tenure,
    required double returnRate,
    double? stepUpAmount,
    double? stepUpPercentage,
  }) {
    logger.i("STPCalculatorController => calculateSTP > start");
    change(null, status: RxStatus.loading());

    final reports = performStepUpFunctions(
      sipAmount: sipAmount,
      depositFrequency: 1,
      tenure: tenure,
      tenureType: 12,
      returnRate: returnRate,
      compoundFrequency: 1,
      stepUpAmount: stepUpAmount,
      stepUpPercentage: stepUpPercentage,
    );

    change(reports, status: RxStatus.success());
    logger.i("STPCalculatorController => calculateSTP > end");
  }
}
