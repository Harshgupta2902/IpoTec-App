import 'package:ipotec/calc_module/modal/core_calculator_invest_value_model.dart';
import 'package:ipotec/calc_module/modal/core_calculator_report_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';

CoreCalculatorReportModel performCompoundInterestCalculation({
  required double sipAmount,
  required int depositFrequency,
  required int tenure,
  required int tenureType,
  required double returnRate,
  required int compoundFrequency,
  double? stepUpAmount,
  double? stepUpPercentage,
}) {
  logger.i("CoreCalculatorReportModel => start");

  int totalMonths = tenureType == 1 ? tenure : tenure * 12;

  int tenureYears = totalMonths % 12 == 0 ? totalMonths ~/ 12 : totalMonths ~/ 12 + 1;
  int tenureRemainingMonths = totalMonths % 12;

  double currentSIPAmount = sipAmount;
  double depositSIPAmount = 0;
  double investedAmount = 0;
  double investedReturns = 0;
  double totalReturns = 0;

  final monthlyReturnRate = returnRate / 12 / 100;

  List<CoreCalculatorInvestValueModel> yearlyReport = [];
  List<List<CoreCalculatorInvestValueModel>> monthlyReport = [];

  for (int year = 1; year <= tenureYears; year++) {
    List<CoreCalculatorInvestValueModel> tempMonthlyReport = [];

    int months = 12;

    if (tenureType == 1) {
      months = year == tenureYears ? tenureRemainingMonths : 12;

      if (tenureRemainingMonths == 0) {
        months = 12;
      }
    }

    for (int month = 1; month <= months; month++) {
      if ((month - 1) % depositFrequency == 0) {
        investedAmount += currentSIPAmount;
        depositSIPAmount += currentSIPAmount;
      }

      if ((month - 1) % compoundFrequency == 0) {
        depositSIPAmount += investedReturns;
        investedReturns = 0;
      }

      double returns = (depositSIPAmount * monthlyReturnRate);
      investedReturns += returns;
      totalReturns += returns;

      tempMonthlyReport.add(
        CoreCalculatorInvestValueModel(
          investAmount: (month - 1) % depositFrequency == 0 ? currentSIPAmount : null,
          invest: investedAmount,
          value: investedAmount + totalReturns,
        ),
      );
    }

    if (stepUpAmount != null) {
      currentSIPAmount = currentSIPAmount + stepUpAmount;
    }

    if (stepUpPercentage != null) {
      currentSIPAmount = currentSIPAmount + (currentSIPAmount * (stepUpPercentage / 100));
    }

    if (tempMonthlyReport.isNotEmpty) {
      yearlyReport.add(tempMonthlyReport.last);
    }
    monthlyReport.add([...tempMonthlyReport]);
  }

  logger.i("CoreCalculatorReportModel => end");

  return CoreCalculatorReportModel(yearlyReport: yearlyReport, monthlyReport: monthlyReport);
}

CoreCalculatorReportModel performCompoundInterestCalculationLumpSum({
  required double lumpSumAmount,
  required int tenure,
  required int tenureType,
  required double returnRate,
  required int compoundFrequency,
}) {
  logger.i("CoreCalculatorReportModel => start");

  int totalMonths = tenureType == 1 ? tenure : tenure * 12;

  int tenureYears = totalMonths % 12 == 0 ? totalMonths ~/ 12 : totalMonths ~/ 12 + 1;
  int tenureRemainingMonths = totalMonths % 12;

  double investedAmount = lumpSumAmount;
  double investedReturns = 0;
  double totalReturns = 0;

  final monthlyReturnRate = returnRate / 12 / 100;

  List<CoreCalculatorInvestValueModel> yearlyReport = [];
  List<List<CoreCalculatorInvestValueModel>> monthlyReport = [];

  for (int year = 1; year <= tenureYears; year++) {
    List<CoreCalculatorInvestValueModel> tempMonthlyReport = [];

    int months = 12;

    if (tenureType == 1) {
      months = year == tenureYears ? tenureRemainingMonths : 12;

      if (tenureRemainingMonths == 0) {
        months = 12;
      }
    }

    for (int month = 1; month <= months; month++) {
      if ((month - 1) % compoundFrequency == 0 && month >= 1) {
        investedAmount += investedReturns;
        investedReturns = 0;
      }

      double returns = (investedAmount * monthlyReturnRate);
      investedReturns += returns;
      totalReturns += returns;

      tempMonthlyReport.add(
        CoreCalculatorInvestValueModel(
          investAmount: null,
          invest: lumpSumAmount,
          value: lumpSumAmount + totalReturns,
        ),
      );
    }

    if (tempMonthlyReport.isNotEmpty) {
      yearlyReport.add(tempMonthlyReport.last);
    }
    monthlyReport.add([...tempMonthlyReport]);
  }
  logger.i("CoreCalculatorReportModel => end");

  return CoreCalculatorReportModel(yearlyReport: yearlyReport, monthlyReport: monthlyReport);
}
