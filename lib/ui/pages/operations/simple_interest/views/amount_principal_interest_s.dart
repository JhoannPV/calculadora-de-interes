import 'package:calculadora_de_interes/domain/controller/calculations/calculate_simple_interest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountPrincipalInterestS extends StatefulWidget {
  const AmountPrincipalInterestS({super.key});

  @override
  State<AmountPrincipalInterestS> createState() =>
      _AmountPrincipalInterestSState();
}

class _AmountPrincipalInterestSState extends State<AmountPrincipalInterestS> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController principalController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  CalculateSimpleInterest csi = Get.find();
  double? interest = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Interes Simple'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: principalController,
                        decoration: const InputDecoration(
                          labelText: 'Valor Presente o Capital Inicial',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Digite el valor del Capital Inicial';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: amountController,
                        decoration: const InputDecoration(
                          labelText: 'Valor Futuro o Monto Final',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Digite el valor del Monto Final';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              csi.calculateInterest(
                                  principal:
                                      double.parse(principalController.text),
                                  amount: double.parse(amountController.text));
                              setState(() {
                                interest = csi.getSimpleInterest();
                              });
                            }
                          },
                          child: const Text('Calcular'),
                        ),
                      ),
                    ],
                  ),
                ),
                interest != 0
                    ? Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Interes Simple: $interest',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ))
                    : const SizedBox(),
              ],
            ),
          ),
        ));
  }
}
