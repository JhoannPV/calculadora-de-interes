import 'dart:math';
import 'package:calculadora_de_interes/domain/controller/data/data.dart';
import 'package:get/get.dart';

class CalculateAnnuities extends GetxController {
  Rxn<double> amount = Rxn<double>(0.0);
  Rxn<double> principal = Rxn<double>(0.0);
  Data data = Get.find();

  void clearValues() {
    amount.value = 0.0;
    principal.value = 0.0;
  }

  void calculateOrdinaryAnnuityVF(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required String typeofinterest}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = 0;
    switch (typeofinterest) {
      case 'Mensual':
        time = timeYear * 12;
        break;
      case 'Bimestral':
        time = timeYear * 6;
        break;
      case 'Trimestral':
        time = timeYear * 4;
        break;
      case 'Cuatrimestral':
        time = timeYear * 3;
        break;
      case 'Semestral':
        time = timeYear * 2;
        break;
      case 'Anual':
        time = timeYear;
        break;
    }
    amount.value = double.parse(
        (annuity * ((pow((1 + rate), time) - 1) / rate)).toStringAsFixed(1));
  }

  void calculateOrdinaryAnnuityVA(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required String typeofinterest}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = 0;
    switch (typeofinterest) {
      case 'Mensual':
        time = timeYear * 12;
        break;
      case 'Bimestral':
        time = timeYear * 6;
        break;
      case 'Trimestral':
        time = timeYear * 4;
        break;
      case 'Cuatrimestral':
        time = timeYear * 3;
        break;
      case 'Semestral':
        time = timeYear * 2;
        break;
      case 'Anual':
        time = timeYear;
        break;
    }
    principal.value = double.parse(
        (annuity * ((1 - pow((1 + rate), -time)) / rate)).toStringAsFixed(1));
  }

  void calculateAdvanceAnnuityVF(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required String typeofinterest}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = 0;
    switch (typeofinterest) {
      case 'Mensual':
        time = timeYear * 12;
        break;
      case 'Bimestral':
        time = timeYear * 6;
        break;
      case 'Trimestral':
        time = timeYear * 4;
        break;
      case 'Cuatrimestral':
        time = timeYear * 3;
        break;
      case 'Semestral':
        time = timeYear * 2;
        break;
      case 'Anual':
        time = timeYear;
        break;
    }
    amount.value = double.parse(
        (annuity * ((pow((1 + rate), time) - 1) / rate) * (1 + rate))
            .toStringAsFixed(1));
  }

  void calculateAdvanceAnnuityVA(
      {required double annuity,
      required double rate,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0,
      required String typeofinterest}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = 0;
    switch (typeofinterest) {
      case 'Mensual':
        time = timeYear * 12;
        break;
      case 'Bimestral':
        time = timeYear * 6;
        break;
      case 'Trimestral':
        time = timeYear * 4;
        break;
      case 'Cuatrimestral':
        time = timeYear * 3;
        break;
      case 'Semestral':
        time = timeYear * 2;
        break;
      case 'Anual':
        time = timeYear;
        break;
    }
    principal.value = double.parse(
        (annuity * ((1 - pow((1 + rate), -time)) / rate) * (1 + rate))
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
      double deferTimeYear = 0,
      required String typeofinterest}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    deferTimeDay = (deferTimeDay / data.getDays.value!.toDouble());
    deferTimeMonth = (deferTimeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    deferTimeYear = deferTimeYear + deferTimeDay + deferTimeMonth;
    double time = 0;
    double defertime = 0;
    switch (typeofinterest) {
      case 'Mensual':
        time = timeYear * 12;
        defertime = deferTimeYear * 12;
        break;
      case 'Bimestral':
        time = timeYear * 6;
        defertime = deferTimeYear * 6;
        break;
      case 'Trimestral':
        time = timeYear * 4;
        defertime = deferTimeYear * 4;
        break;
      case 'Cuatrimestral':
        time = timeYear * 3;
        defertime = deferTimeYear * 3;
        break;
      case 'Semestral':
        time = timeYear * 2;
        defertime = deferTimeYear * 2;
        break;
      case 'Anual':
        time = timeYear;
        defertime = deferTimeYear;
        break;
    }
    amount.value = double.parse((annuity *
            ((pow((1 + rate), time) - 1) / rate) *
            (pow((1 + rate), -defertime)))
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
      double deferTimeYear = 0,
      required String typeofinterest}) {
    rate = rate / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    deferTimeDay = (deferTimeDay / data.getDays.value!.toDouble());
    deferTimeMonth = (deferTimeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    deferTimeYear = deferTimeYear + deferTimeDay + deferTimeMonth;
    double time = 0;
    double defertime = 0;
    switch (typeofinterest) {
      case 'Mensual':
        time = timeYear * 12;
        defertime = deferTimeYear * 12;
        break;
      case 'Bimestral':
        time = timeYear * 6;
        defertime = deferTimeYear * 6;
        break;
      case 'Trimestral':
        time = timeYear * 4;
        defertime = deferTimeYear * 4;
        break;
      case 'Cuatrimestral':
        time = timeYear * 3;
        defertime = deferTimeYear * 3;
        break;
      case 'Semestral':
        time = timeYear * 2;
        defertime = deferTimeYear * 2;
        break;
      case 'Anual':
        time = timeYear;
        defertime = deferTimeYear;
        break;
    }
    principal.value = double.parse((annuity *
            ((1 - pow((1 + rate), -time)) / rate) *
            (pow((1 + rate), -defertime)))
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
