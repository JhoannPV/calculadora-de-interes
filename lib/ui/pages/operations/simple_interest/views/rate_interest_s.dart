import 'package:calculadora_de_interes/domain/controller/calculations/calculate_simple_interest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RateInterestS extends StatefulWidget {
  const RateInterestS({super.key});

  @override
  State<RateInterestS> createState() => _RateInterestSState();
}

class _RateInterestSState extends State<RateInterestS> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController principalController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController timeDayController = TextEditingController();
  TextEditingController timeMonthController = TextEditingController();
  TextEditingController timeYearController = TextEditingController();
  CalculateSimpleInterest csi = Get.find();
  double? rate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasa de Interes'),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text('Tiempo',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        controller: timeYearController,
                        decoration: const InputDecoration(
                          labelText: 'Años',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty
                            ? 'Digite el valor del tiempo'
                            : null,
                      ),
                      TextField(
                        controller: timeMonthController,
                        decoration: const InputDecoration(
                          labelText: 'Meses',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: timeDayController,
                        decoration: const InputDecoration(
                          labelText: 'Días',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              csi.calculateRate(
                                  principal:
                                      double.parse(principalController.text),
                                  amount: double.parse(amountController.text),
                                  timeDay: timeDayController.text.isEmpty
                                      ? 0
                                      : double.parse(timeDayController.text),
                                  timeMonth: timeMonthController.text.isEmpty
                                      ? 0
                                      : double.parse(timeMonthController.text),
                                  timeYear: timeYearController.text.isEmpty
                                      ? 0
                                      : double.parse(timeYearController.text));
                              setState(() {
                                rate = csi.getRate2();
                              });
                            }
                          },
                          child: const Text('Calcular'),
                        ),
                      ),
                    ],
                  ),
                ),
                rate != 0
                    ? Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Tasa de Interes: $rate %',
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
