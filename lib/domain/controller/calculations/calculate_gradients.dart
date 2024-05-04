import 'dart:math';

import 'package:calculadora_de_interes/domain/controller/data/data.dart';
import 'package:get/get.dart';

class CalculateGradients extends GetxController {
  Rxn<double> futureValue = Rxn<double>(0.0);
  Rxn<double> presentValue = Rxn<double>(0.0);
  Rxn<double> quotaValue = Rxn<double>(0.0);
  Data data = Get.find();

  void clearValues() {
    futureValue.value = 0.0;
    presentValue.value = 0.0;
    quotaValue.value = 0.0;
  }

  void calculateIncreasingLinearGradientVF(
      {required double constantValue,
      required double gradientValueL,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
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
    futureValue.value = double.parse(
        (constantValue * ((pow(1 + rate, time) - 1) / rate) +
                (gradientValueL / rate) *
                    (((pow(1 + rate, time) - 1) / rate) - time))
            .toStringAsFixed(1));
  }

  void calculateIncreasingLinearGradientVP(
      {required double constantValue,
      required double gradientValueL,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
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
    presentValue.value = double.parse(
        (constantValue * ((1 - pow(1 + rate, -time)) / rate) +
                (gradientValueL / rate) *
                    (((1 - pow(1 + rate, -time)) / rate) -
                        (time / pow(1 + rate, time))))
            .toStringAsFixed(1));
  }

  void calculateDecreasingLinearGradientVF(
      {required double constantValue,
      required double gradientValueL,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
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
    futureValue.value = double.parse(
        (constantValue * ((pow(1 + rate, time) - 1) / rate) -
                (gradientValueL / rate) *
                    (((pow(1 + rate, time) - 1) / rate) - time))
            .toStringAsFixed(1));
  }

  void calculateDecreasingLinearGradientVP(
      {required double constantValue,
      required double gradientValueL,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
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
    presentValue.value = double.parse(
        (constantValue * ((1 - pow(1 + rate, -time)) / rate) -
                (gradientValueL / rate) *
                    (((1 - pow(1 + rate, -time)) / rate) -
                        (time / pow(1 + rate, time))))
            .toStringAsFixed(1));
  }

  void calculateIncreasingGeometricGradientVF(
      {required double constantValue,
      required double gradientValueG,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    gradientValueG = gradientValueG / 100;
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
    futureValue.value = double.parse(((constantValue *
                (pow(1 + gradientValueG, time) - pow(1 + rate, time))) /
            (gradientValueG - rate))
        .toStringAsFixed(1));
  }

  void calculateIncreasingGeometricGradientVP(
      {required double constantValue,
      required double gradientValueG,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    gradientValueG = gradientValueG / 100;
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
    presentValue.value = double.parse(((constantValue *
                (pow(1 + gradientValueG, time) * pow(1 + rate, -time) - 1)) /
            (gradientValueG - rate))
        .toStringAsFixed(1));
  }

  void calculateDecreasingGeometricGradientVF(
      {required double constantValue,
      required double gradientValueG,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    gradientValueG = gradientValueG / 100;
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
    futureValue.value = double.parse(((constantValue *
                (pow(1 - gradientValueG, time) - pow(1 + rate, time))) /
            (gradientValueG + rate))
        .toStringAsFixed(1));
  }

  void calculateDecreasingGeometricGradientVP(
      {required double constantValue,
      required double gradientValueG,
      required double rate,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    rate = rate / 100;
    gradientValueG = gradientValueG / 100;
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
    presentValue.value = double.parse(((constantValue *
                (pow(1 - gradientValueG, time) * pow(1 + rate, -time) - 1)) /
            (gradientValueG + rate))
        .toStringAsFixed(1));
  }

  void calculateIncreasingLinearGradientQuota(
      {required double constantValue,
      required double gradientValueL,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = timeYear;
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
    quotaValue.value = double.parse(
        (constantValue + (time - 1) * gradientValueL).toStringAsFixed(1));
  }

  void calculateDecreasingLinearGradientQuota(
      {required double constantValue,
      required double gradientValueL,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = timeYear;
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
    quotaValue.value = double.parse(
        (constantValue - (time - 1) * gradientValueL).toStringAsFixed(1));
  }

  void calculateIncreasingGeometricGradientQuota(
      {required double constantValue,
      required double gradientValueG,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    gradientValueG = gradientValueG / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = timeYear;
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
    quotaValue.value = double.parse(
        (constantValue * pow(1 + gradientValueG, time - 1)).toStringAsFixed(1));
  }

  void calculateDecreasingGeometricGradientQuota(
      {required double constantValue,
      required double gradientValueG,
      required String typeofinterest,
      double timeDay = 0,
      double timeMonth = 0,
      double timeYear = 0}) {
    gradientValueG = gradientValueG / 100;
    timeDay = (timeDay / data.getDays.value!.toDouble());
    timeMonth = (timeMonth / 12);
    timeYear = timeYear + timeDay + timeMonth;
    double time = timeYear;
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
    quotaValue.value = double.parse(
        (constantValue * pow(1 - gradientValueG, time - 1)).toStringAsFixed(1));
  }

  Rxn<double> get getFutureValue => futureValue;
  Rxn<double> get getPresentValue => presentValue;
  Rxn<double> get getQuotaValue => quotaValue;
}
