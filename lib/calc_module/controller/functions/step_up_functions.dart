import 'package:ipotec/calc_module/controller/compound_interest_calculation.dart';
import 'package:ipotec/calc_module/modal/core_calculator_report_model.dart';

performStepUpFunctions({
  required double sipAmount,
  required int depositFrequency,
  required int tenure,
  required int tenureType,
  required double returnRate,
  required int compoundFrequency,
  double? stepUpAmount,
  double? stepUpPercentage,
}) {
  final topUpReports = performCompoundInterestCalculation(
    sipAmount: sipAmount,
    depositFrequency: depositFrequency,
    returnRate: returnRate,
    compoundFrequency: compoundFrequency,
    tenure: tenure,
    tenureType: tenureType,
    stepUpAmount: stepUpAmount,
    stepUpPercentage: stepUpPercentage,
  );

  final reports = performCompoundInterestCalculation(
    sipAmount: sipAmount,
    depositFrequency: depositFrequency,
    returnRate: returnRate,
    compoundFrequency: compoundFrequency,
    tenure: tenure,
    tenureType: tenureType,
  );

  return CoreStepUpSIPModel(
    sipAmount: sipAmount,
    stepUpAmount: stepUpAmount,
    stepUpPercentage: stepUpPercentage,
    tenureInYears: tenure.toDouble(),
    returnRate: returnRate,
    reports: reports,
    topUpReports: topUpReports,
  );
}

class CoreStepUpSIPModel {
  CoreStepUpSIPModel({
    required this.sipAmount,
    required this.stepUpAmount,
    required this.stepUpPercentage,
    required this.tenureInYears,
    required this.returnRate,
    required this.reports,
    required this.topUpReports,
  });

  final double sipAmount;
  final double? stepUpAmount;
  final double? stepUpPercentage;
  final double tenureInYears;
  final double returnRate;
  final CoreCalculatorReportModel reports;
  final CoreCalculatorReportModel topUpReports;
}
