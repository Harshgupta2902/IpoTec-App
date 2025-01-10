import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/functions/lumpsum_functions.dart';
import 'package:ipotec/calc_module/controller/functions/sip_functions.dart';
import 'package:ipotec/utilities/constants/functions.dart';

class LumpsumCalculatorController extends GetxController with StateMixin<CoreLumpsumModel> {
  calculateLumpsum({
    required double lumpSumAmount,
    required int tenure,
    required double returnRate,
  }) {
    logger.i("LumpsumCalculatorController => calculateSIP > start");
    change(null, status: RxStatus.loading());

    logger.i("LumpsumCalculatorController => calculateSIP > start ");

    final reports = performLumpSumFunctions(
      lumpSumAmount: lumpSumAmount,
      tenure: tenure,
      tenureType: 12,
      returnRate: returnRate,
      compoundFrequency: 12,
    );

    change(reports, status: RxStatus.success());
    logger.i("LumpsumCalculatorController => calculateSIP > end");
  }

  resetController() {
    change(null, status: RxStatus.success());
  }
}
