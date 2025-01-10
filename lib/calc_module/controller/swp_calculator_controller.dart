import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/functions/swp_functions.dart';
import 'package:ipotec/utilities/constants/functions.dart';

class SWPCalculatorController extends GetxController with StateMixin<CoreSWPModel> {
  calculateSWP({
    required double corpusAmount,
    required double pensionAmount,
    required int timePeriodInYears,
    required double returnRate,
  }) {
    logger.i("SWPCalculatorController => calculateSWP > Start");
    change(null, status: RxStatus.loading());

    try {
      final reports = performSWPCalculation(
        corpusAmount: corpusAmount,
        tenureInYears: timePeriodInYears,
        returnRate: returnRate,
        pensionAmount: pensionAmount,
      );

      logger.i("Calculation Successful => Reports Generated: $reports");
      change(reports, status: RxStatus.success());
    } catch (e) {
      logger.e("Error during SWP Calculation => $e");
      change(null, status: RxStatus.error("Error in SWP Calculation"));
    }

    logger.i("SWPCalculatorController => calculateSWP > End");
  }
}
