import 'package:calculadora_de_interes/domain/controller/calculations/calcular_interes_simple.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleInterest extends StatefulWidget {
  const SimpleInterest({super.key});

  @override
  State<SimpleInterest> createState() => _SimpleInterestState();
}

class _SimpleInterestState extends State<SimpleInterest> {
  CalculateSimpleInterest cis = Get.find();
  double? interess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interes Simple'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              child: const Text("Hola"),
              onPressed: () {
                setState(() {
                  interess = cis.calculateSimpleInterest(
                      interes: 2, monto: 3, tasa: 4, tiempo: 5);
                });
              }),
          interess != null ? Text("Interes Simple: $interess") : const Text(""),
        ],
      ),
    );
  }
}
