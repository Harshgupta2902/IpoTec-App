import 'package:ipotec/calc_module/modal/core_calculator_invest_value_model.dart';
import 'package:ipotec/calc_module/modal/core_calculator_report_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';

CoreSWPModel performSWPCalculation({
  required double corpusAmount,
  required double pensionAmount,
  required double returnRate,
  required int tenureInYears,
}) {
  // bool inflationAdjustedSWP = false;
  // double inflationRate = 8;
  int startWithdrawalAfterInYears = 0;

  logger.d(
      "performSWPCalculation - corpusAmount: ${format2INR(corpusAmount)} | pensionAmount: ${format2INR(pensionAmount)} | returnRate: $returnRate | tenureInYears: $tenureInYears");
  final monthlyReturnRate = returnRate / 12 / 100;

  double remainingCorpus = corpusAmount;
  double swpAmount = pensionAmount;
  double withdrawnAmount = 0;
  double interestEarned = 0;

  int totalTenure = tenureInYears + startWithdrawalAfterInYears;
  double holdingTenureInMonths = 0;

  List<CoreCalculatorInvestValueModel> yearlyReport = [];
  List<List<CoreCalculatorInvestValueModel>> monthlyReport = [];

  for (int year = 1; year <= totalTenure; year++) {
    List<CoreCalculatorInvestValueModel> tempMonthlyReport = [];

    final yearStartCorpus = remainingCorpus;
    double yearInterestEarned = 0;
    double yearWithdrawAmount = 0;

    for (int month = 1; month <= 12; month++) {
      holdingTenureInMonths++;
      bool canWithdraw = ((holdingTenureInMonths / 12) > startWithdrawalAfterInYears);

      final balanceBegin = remainingCorpus;

      double returnOnCorpus = remainingCorpus * monthlyReturnRate;
      interestEarned += returnOnCorpus;
      yearInterestEarned += returnOnCorpus;

      if (month == 12) remainingCorpus += yearInterestEarned;

      if (canWithdraw) {
        remainingCorpus -= swpAmount;
        withdrawnAmount += swpAmount;
        yearWithdrawAmount += swpAmount;
      }

      tempMonthlyReport.add(
        CoreCalculatorInvestValueModel(
          withdrawAmount: canWithdraw ? swpAmount : null,
          invest: balanceBegin,
          interestEarned: returnOnCorpus,
          value: remainingCorpus,
        ),
      );
    }

    yearlyReport.add(
      CoreCalculatorInvestValueModel(
        invest: yearStartCorpus,
        interestEarned: yearInterestEarned,
        value: tempMonthlyReport.last.value,
        withdrawAmount: yearWithdrawAmount,
      ),
    );

    monthlyReport.add([...tempMonthlyReport]);

    // if (inflationAdjustedSWP) {
    //   swpAmount += (swpAmount * inflationRate) / 100;
    // }
  }

  return CoreSWPModel(
    pensionAmount: pensionAmount,
    returnRate: returnRate,
    withdrawnAmount: withdrawnAmount,
    interestEarned: interestEarned,
    corpusAmount: corpusAmount,
    tenureInYears: tenureInYears,
    reports: CoreCalculatorReportModel(yearlyReport: yearlyReport, monthlyReport: monthlyReport),
  );
}

class CoreSWPModel {
  CoreSWPModel({
    required this.corpusAmount,
    required this.pensionAmount,
    required this.withdrawnAmount,
    required this.interestEarned,
    required this.returnRate,
    required this.tenureInYears,
    required this.reports,
  });
  final double corpusAmount;
  final double pensionAmount;
  final double withdrawnAmount;
  final double interestEarned;
  final double returnRate;
  final int tenureInYears;
  final CoreCalculatorReportModel reports;
  double get gainLossPer =>
      ((interestEarned).toInt() / reports.yearlyReport.last.value.toInt()) * 100;
}

class CoreSWPSchemeModel {
  CoreSWPSchemeModel({
    required this.corpusAmount,
    required this.pensionAmount,
    required this.totalWithdrawal,
    required this.returnRate,
    required this.noOfInstallments,
    required this.reports,
    this.startDate,
    this.endDate,
  });
  final double corpusAmount;
  final double pensionAmount;
  final double totalWithdrawal;
  final double returnRate;
  final int noOfInstallments;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<CoreCalculatorInvestValueModel> reports;
}
