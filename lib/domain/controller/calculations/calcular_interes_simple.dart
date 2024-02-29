import 'package:get/get.dart';

class CalculateSimpleInterest extends GetxController {
  double calculateSimpleInterest(
      {required double interes,
      required double monto,
      required double tasa,
      required double tiempo}) {
    double intrs;
    intrs = interes * monto * tasa * tiempo;
    return intrs;
  }
}
