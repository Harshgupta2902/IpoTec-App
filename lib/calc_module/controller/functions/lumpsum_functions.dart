
import 'package:ipotec/calc_module/controller/compound_interest_calculation.dart';
import 'package:ipotec/calc_module/modal/core_calculator_report_model.dart';

performLumpSumFunctions({
  required double lumpSumAmount,
  required int tenure,
  required int tenureType,
  required double returnRate,
  required int compoundFrequency,
}) {
  final reports = performCompoundInterestCalculationLumpSum(
    lumpSumAmount: lumpSumAmount,
    returnRate: returnRate,
    compoundFrequency: compoundFrequency,
    tenure: tenure,
    tenureType: tenureType,
  );

  double totalInvestedAmount = reports.yearlyReport.last.invest;
  double totalReturns = reports.yearlyReport.last.value - totalInvestedAmount;

  return CoreLumpsumModel(
    lumpSumAmount: lumpSumAmount,
    tenureInYears: tenure.toDouble(),
    returnRate: returnRate,
    reports: reports,
    totalInvestAmount: totalInvestedAmount,
    totalReturns: totalReturns,
  );
}

class CoreLumpsumModel {
  CoreLumpsumModel({
    required this.lumpSumAmount,
    required this.tenureInYears,
    required this.returnRate,
    required this.reports,
    required this.totalInvestAmount,
    required this.totalReturns,
  });

  final double lumpSumAmount;
  final double tenureInYears;
  final double returnRate;
  final double totalInvestAmount;
  final double totalReturns;
  final CoreCalculatorReportModel reports;
}
