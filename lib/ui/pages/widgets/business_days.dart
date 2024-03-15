import 'package:calculadora_de_interes/domain/controller/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessDays extends StatefulWidget {
  const BusinessDays({
    super.key,
  });

  @override
  State<BusinessDays> createState() => _BusinessDaysState();
}

class _BusinessDaysState extends State<BusinessDays> {
  Data data = Get.find();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            data.changeDays();
          });
        },
        backgroundColor: const Color(0xFF013542),
        child: Text(
          '${data.getDays.value}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ));
  }
}
