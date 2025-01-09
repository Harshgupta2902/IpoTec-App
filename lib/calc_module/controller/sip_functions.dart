import 'dart:math';
import 'package:ipotec/calc_module/controller/compound_interest_calculation.dart';
import 'package:ipotec/calc_module/modal/core_calculator_report_model.dart';

performSipCalculateAmount({
  required double corpusAmount,
  required double rate,
  required double tenureInYears,
  int depositFrequency = 1,
}) {
  // A = PMT × (((1 + r/n)^(nt) - 1) ÷ (r/n)) × (1+r/n)

  // Compounded rate of return (monthly rate)
  double i = rate / 100/ 12;

  double monthly = corpusAmount /
      ((pow(1 + i / depositFrequency, depositFrequency * tenureInYears*12) - 1) /
          (i / depositFrequency) *
          (1 + i / depositFrequency));

  return monthly;
}


double performSipCalculateFutureValue({
  required double monthlyInvestment,
  required double rate,
  required double tenureInYears,
  int depositFrequency = 12, // default to monthly
}) {
  // Convert annual rate to monthly rate
  double i = rate / 100 / depositFrequency;

  // Total number of periods (monthly contributions over the tenure)
  int n = (tenureInYears * depositFrequency).toInt();

  // Future value formula
  double futureValue = monthlyInvestment *
      ((pow(1 + i, n) - 1) / i) *
      (1 + i);

  return futureValue;
}

CoreSIPModel performSIPFunctions({
  required double sipAmount,
  required int depositFrequency,
  required int tenure,
  required int tenureType,
  required double returnRate,
  required int compoundFrequency,
}) {
  final reports = performCompoundInterestCalculation(
    sipAmount: sipAmount,
    depositFrequency: depositFrequency,
    returnRate: returnRate,
    compoundFrequency: compoundFrequency,
    tenure: tenure,
    tenureType: tenureType,
  );

  double totalInvestedAmount = reports.yearlyReport.last.invest;
  double totalReturns = reports.yearlyReport.last.value - totalInvestedAmount;

  return CoreSIPModel(
    sipAmount: sipAmount,
    tenureInYears: tenure.toDouble(),
    returnRate: returnRate,
    reports: reports,
    totalInvestAmount: totalInvestedAmount,
    totalReturns: totalReturns,
  );
}

class CoreSIPModel {
  CoreSIPModel({
    required this.sipAmount,
    required this.tenureInYears,
    required this.returnRate,
    required this.reports,
    required this.totalInvestAmount,
    required this.totalReturns,
  });

  final double sipAmount;
  final double tenureInYears;
  final double returnRate;
  final double totalInvestAmount;
  final double totalReturns;
  final CoreCalculatorReportModel reports;
}
