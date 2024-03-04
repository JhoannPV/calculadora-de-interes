import 'dart:math';
import 'package:get/get.dart';

class CalculateAnnuities extends GetxController {
  Rxn<double> amount = Rxn<double>(0.0);
  Rxn<double> principal = Rxn<double>(0.0);

  void clearValues() {
    amount.value = 0.0;
    principal.value = 0.0;
  }

  void calculateOrdinaryAnnuityVF(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    timeDay = (timeDay / 365);
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    amount.value = double.parse(
        (annuity * ((pow((1 + rate), timeYear) - 1) / rate))
            .toStringAsFixed(1));
  }

  void calculateOrdinaryAnnuityVA(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    timeDay = (timeDay / 365);
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    principal.value = double.parse(
        (annuity * ((1 - pow((1 + rate), -timeYear)) / rate))
            .toStringAsFixed(1));
  }

  void calculateAdvanceAnnuityVF(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    timeDay = (timeDay / 365);
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    amount.value = double.parse(
        (annuity * ((pow((1 + rate), timeYear) - 1) / rate) * (1 + rate))
            .toStringAsFixed(1));
  }

  void calculateAdvanceAnnuityVA(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    timeDay = (timeDay / 365);
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    principal.value = double.parse(
        (annuity * ((1 - pow((1 + rate), -timeYear)) / rate) * (1 + rate))
            .toStringAsFixed(1));
  }

  void calculateDeferredAnnuityVF(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      double deferTimeDay = 0,
      double deferTimeMonth = 0,
      double deferTimeYear = 0}) {
    rate = rate / 100;
    timeDay = (timeDay / 365);
    timeMonth = (timeMonth / 12);
    deferTimeDay = (deferTimeDay / 365);
    deferTimeMonth = (deferTimeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    deferTimeYear = deferTimeYear + deferTimeDay + deferTimeMonth;
    amount.value = double.parse((annuity *
            ((pow((1 + rate), timeYear) - 1) / rate) *
            (pow((1 + rate), -deferTimeYear)))
        .toStringAsFixed(1));
  }

  void calculateDeferredAnnuityVA(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      double deferTimeDay = 0,
      double deferTimeMonth = 0,
      double deferTimeYear = 0}) {
    rate = rate / 100;
    timeDay = (timeDay / 365);
    timeMonth = (timeMonth / 12);
    deferTimeDay = (deferTimeDay / 365);
    deferTimeMonth = (deferTimeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    deferTimeYear = deferTimeYear + deferTimeDay + deferTimeMonth;
    principal.value = double.parse((annuity *
            ((1 - pow((1 + rate), -timeYear)) / rate) *
            (pow((1 + rate), -deferTimeYear)))
        .toStringAsFixed(1));
  }

  void calculatePerpetualAnnuityVA(
      {required double annuity, required double rate}) {
    rate = rate / 100;
    amount.value = double.parse((annuity / rate).toStringAsFixed(1));
  }

  Rxn<double> get getAmount => amount;
  Rxn<double> get getPrincipal => principal;
}
