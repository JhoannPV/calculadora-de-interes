import 'package:get/get.dart';

class Data extends GetxController {
  Rxn<int> days = Rxn<int>(365);

  void changeDays() {
    if (days.value == 365) {
      days.value = 360;
    } else {
      days.value = 365;
    }
  }

  Rxn<int> get getDays => days;
}
