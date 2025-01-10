import 'package:ipotec/calc_module/modal/core_calculator_invest_value_model.dart';
import 'package:ipotec/calc_module/modal/core_calculator_report_model.dart';

CoreSTPModel performSTPCalculation(
    double initialAmount,
    double stpAmount,
    double liquidReturn,
    double equityReturn,
    int tenure,
    int tenureType,
    ) {
  double equityInvested = 0;

  double liquidValue = initialAmount;
  double equityValue = 0;

  double liquidReturns = 0;
  double equityReturns = 0;

  final List<CoreCalculatorInvestValueModel> yearlyReportEquity = [];
  final List<List<CoreCalculatorInvestValueModel>> monthlyReportEquity = [];

  final List<CoreCalculatorInvestValueModel> yearlyReportLiquid = [];
  final List<List<CoreCalculatorInvestValueModel>> monthlyReportLiquid = [];

  int totalMonths = tenureType == 1 ? tenure : tenure * 12;

  int tenureYears = totalMonths % 12 == 0 ? totalMonths ~/ 12 : totalMonths ~/ 12 + 1;
  int tenureRemainingMonths = totalMonths % 12;

  for (int year = 1; year <= tenureYears; year++) {
    List<CoreCalculatorInvestValueModel> tempMonthlyReportLiquid = [];
    List<CoreCalculatorInvestValueModel> tempMonthlyReportEquity = [];

    int months = 12;

    if (tenureType == 1) {
      months = year == tenureYears ? tenureRemainingMonths : 12;

      if (tenureRemainingMonths == 0) {
        months = 12;
      }
    }

    for (int month = 1; month <= months; month++) {
      final openBalance = liquidValue;

      equityInvested += stpAmount;

      liquidValue -= stpAmount;
      equityValue += stpAmount;

      double returnOnLiquid = liquidValue * liquidReturn;
      double returnOnEquity = equityValue * equityReturn;

      liquidReturns += returnOnLiquid;
      equityReturns += returnOnEquity;

      liquidValue += returnOnLiquid;
      equityValue += returnOnEquity;

      tempMonthlyReportLiquid
          .add(CoreCalculatorInvestValueModel(invest: openBalance, value: liquidValue));
      tempMonthlyReportEquity
          .add(CoreCalculatorInvestValueModel(invest: equityInvested, value: equityValue));

      // debugPrint(
      //     "$year-$month | ${openBalance.toInt()}  | ${liquidValue.toInt()} | ${returnOnLiquid.toInt()} | ${equityInvested.toInt()} | ${returnOnEquity.toInt()} | ${(liquidValue + equityValue).toInt()}");
    }

    yearlyReportLiquid.add(tempMonthlyReportLiquid.last);
    yearlyReportEquity.add(tempMonthlyReportEquity.last);

    monthlyReportLiquid.add([...tempMonthlyReportLiquid]);
    monthlyReportEquity.add([...tempMonthlyReportEquity]);
  }

  return CoreSTPModel(
    stpAmount: stpAmount,
    initialAmount: initialAmount,
    growthValue: (initialAmount + liquidReturns + equityReturns),
    equityReturns: equityReturns,
    liquidReturns: liquidReturns,
    liquidReport: CoreCalculatorReportModel(
      monthlyReport: monthlyReportLiquid,
      yearlyReport: yearlyReportLiquid,
    ),
    equityReport: CoreCalculatorReportModel(
      monthlyReport: monthlyReportEquity,
      yearlyReport: yearlyReportEquity,
    ),
  );
}

class CoreSTPModel {
  CoreSTPModel({
    required this.stpAmount,
    required this.initialAmount,
    required this.growthValue,
    required this.liquidReport,
    required this.equityReport,
    required this.equityReturns,
    required this.liquidReturns,
  });

  final double stpAmount;
  final double initialAmount;
  final double growthValue;
  final double liquidReturns;
  final double equityReturns;
  final CoreCalculatorReportModel liquidReport;
  final CoreCalculatorReportModel equityReport;
  double get gainLossPer => ((growthValue - initialAmount).toInt() / growthValue.toInt()) * 100;
}
