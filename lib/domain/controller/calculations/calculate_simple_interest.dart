import 'package:calculadora_de_interes/domain/controller/data/data.dart';
import 'package:get/get.dart';

class CalculateSimpleInterest extends GetxController {
  Rxn<double> simpleInterest = Rxn<double>(0.0);
  Rxn<double> amount = Rxn<double>(0.0);
  Rxn<double> principal = Rxn<double>(0.0);
  Rxn<double> rate = Rxn<double>(0.0);
  Rxn<double> rate2 = Rxn<double>(0.0);
  Rxn<double> time = Rxn<double>(0.0);
  Data data = Get.find();

  void clearValues() {
    simpleInterest.value = 0.0;
    amount.value = 0.0;
    principal.value = 0.0;
    rate.value = 0.0;
    rate2.value = 0.0;
    time.value = 0.0;
  }

  void calculateSimpleInterest(
      {required double principal,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    simpleInterest.value =
        double.parse(((principal * rate * timeYear)).toStringAsFixed(1));
    amount.value =
        double.parse((principal + simpleInterest.value!).toStringAsFixed(1));
  }

  void calculateTime(
      {required double principal,
      required double rate,
      required double amount}) {
    rate = rate / 100;
    time.value = double.parse(
        ((amount - principal) / (principal * rate)).toStringAsFixed(1));
  }

  void calculateTime2(
      {required double principal,
      required double rate,
      required double simpleInterest}) {
    rate = rate / 100;
    time.value = double.parse(
        ((simpleInterest) / (principal * rate)).toStringAsFixed(1));
  }

  void calculatePrincipal(
      {required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required double amount}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    principal.value =
        double.parse((amount / (1 + (rate * timeYear))).toStringAsFixed(1));
  }

  void calculatePrincipal2(
      {required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required double simpleInterest}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    principal.value =
        double.parse((simpleInterest / (rate * timeYear)).toStringAsFixed(1));
  }

  void calculateRate(
      {required double principal,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required double amount}) {
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    rate.value = (amount - principal) / (principal * timeYear);
    rate2.value = double.parse((rate.value! * 100).toStringAsFixed(1));
  }

  void calculateRate2(
      {required double principal,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required double simpleInterest}) {
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    rate.value = simpleInterest / (principal * timeYear);
    rate2.value = double.parse((rate.value! * 100).toStringAsFixed(1));
  }

  void calculateInterest({
    required double principal,
    required double amount,
  }) {
    simpleInterest.value = amount - principal;
  }

  Rxn<double> get getSimpleInterest => simpleInterest;
  Rxn<double> get getAmount => amount;
  Rxn<double> get getPrincipal => principal;
  Rxn<double> get getRate2 => rate2;
  Rxn<double> get getTime => time;
}
