
import 'package:ipotec/calc_module/modal/core_calculator_invest_value_model.dart';

class CoreCalculatorReportModel {
  CoreCalculatorReportModel({
    required this.yearlyReport,
    required this.monthlyReport,
    this.maximumValue,
    this.minimumValue
  });
  final List<CoreCalculatorInvestValueModel> yearlyReport;
  final List<List<CoreCalculatorInvestValueModel>> monthlyReport;
  double? minimumValue;
  double? maximumValue;
}
