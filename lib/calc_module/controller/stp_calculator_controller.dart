import 'package:get/get.dart';
import 'package:ipotec/calc_module/controller/functions/stp_functions.dart';
import 'package:ipotec/utilities/constants/functions.dart';

class STPCalculatorController extends GetxController with StateMixin<CoreSTPModel> {
  calculateSTP({
    required double investmentAmount,
    required double stpAmount,
    required int tenure,
    required double liquidReturn,
    required equityReturn,
  }) {
    logger.i("STPCalculatorController => calculateSTP > start");
    change(null, status: RxStatus.loading());

    logger.i("---------- $investmentAmount | $tenure | $liquidReturn | $equityReturn");

    logger.i("STPCalculatorController => calculateSTP > start $stpAmount");

    final reports = performSTPCalculation(
      investmentAmount,
      stpAmount,
      liquidReturn / 12 / 100,
      equityReturn / 12 / 100,
      tenure,
      12,
    );

    change(reports, status: RxStatus.success());
    logger.i("STPCalculatorController => calculateSTP > end");
  }
}
