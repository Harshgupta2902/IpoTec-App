import 'package:ipotec/utilities/constants/functions.dart';

class CoreCalculatorInvestValueModel {
  CoreCalculatorInvestValueModel({
    required this.invest,
    required this.value,
    this.investAmount,
    this.units,
    this.interestEarned,
    this.withdrawAmount,
  });

  final double? investAmount;
  final double? withdrawAmount;
  final double? interestEarned;
  final double? units;
  final double invest;
  final double value;

  String get currencyInvestedAmount => format2INR(investAmount);
  String get currencyInvested => format2INR(invest);
  String get currencyValue => format2INR(value);
  String get currencyGainLoss => format2INR(value - invest);
  String get currencyWithdrawAmount => format2INR(withdrawAmount);
  double get currencyGainLossPer => ((value - invest) / value) * 100;
}
