import 'package:calculadora_de_interes/domain/controller/calculations/calculate_simple_interest.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleInterest extends StatefulWidget {
  const SimpleInterest({super.key});

  @override
  State<SimpleInterest> createState() => _SimpleInterestState();
}

class _SimpleInterestState extends State<SimpleInterest> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController principalController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeDayController = TextEditingController();
  TextEditingController timeMonthController = TextEditingController();
  TextEditingController timeYearController = TextEditingController();
  CalculateSimpleInterest csi = Get.find();
  double? interest = 0.0;
  double? amount = 0.0;
  double? principal = 0.0;
  double? rate = 0.0;
  double? time = 0.0;
  int optionAnnuity = 0;

  @override
  void dispose() {
    principalController.dispose();
    amountController.dispose();
    rateController.dispose();
    timeDayController.dispose();
    timeMonthController.dispose();
    timeYearController.dispose();
    super.dispose();
  }

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 30,
                      onPageChanged: (index, reason) {
                        setState(() {
                          optionAnnuity = index;
                        });
                      },
                    ),
                    items: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_left),
                          Text('Interes Simple y Monto',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_left),
                          Text('Tasa de Interes',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_left),
                          Text('Tiempo',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_left),
                          Text('Capital Inicial',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_left),
                          Text('Monto - Capital = Interes',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_right),
                        ],
                      )
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return i;
                        },
                      );
                    }).toList(),
                  ),
                ),
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      optionAnnuity == 3
                          ? const SizedBox()
                          : TextFormField(
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
                      optionAnnuity == 2 ||
                              optionAnnuity == 1 ||
                              optionAnnuity == 3 ||
                              optionAnnuity == 4
                          ? TextFormField(
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
                            )
                          : const SizedBox(),
                      optionAnnuity == 1 || optionAnnuity == 4
                          ? const SizedBox()
                          : TextFormField(
                              controller: rateController,
                              decoration: const InputDecoration(
                                labelText: 'Interes (%)',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Digite el valor de la tasa';
                                }
                                return null;
                              },
                            ),
                      optionAnnuity == 2 || optionAnnuity == 4
                          ? const SizedBox()
                          : Time(
                              timeYearController: timeYearController,
                              timeMonthController: timeMonthController,
                              timeDayController: timeDayController),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              if (optionAnnuity == 0) {
                                csi.calculateSimpleInterest(
                                    principal:
                                        double.parse(principalController.text),
                                    rate: double.parse(rateController.text),
                                    timeDay: timeDayController.text.isEmpty
                                        ? 0
                                        : double.parse(timeDayController.text),
                                    timeMonth: timeMonthController.text.isEmpty
                                        ? 0
                                        : double.parse(
                                            timeMonthController.text),
                                    timeYear: timeYearController.text.isEmpty
                                        ? 0
                                        : double.parse(
                                            timeYearController.text));
                                setState(() {
                                  amount = csi.getAmount();
                                  interest = csi.getSimpleInterest();
                                });
                              } else if (optionAnnuity == 1) {
                                csi.calculateRate(
                                    principal:
                                        double.parse(principalController.text),
                                    amount: double.parse(amountController.text),
                                    timeDay: timeDayController.text.isEmpty
                                        ? 0
                                        : double.parse(timeDayController.text),
                                    timeMonth: timeMonthController.text.isEmpty
                                        ? 0
                                        : double.parse(
                                            timeMonthController.text),
                                    timeYear: timeYearController.text.isEmpty
                                        ? 0
                                        : double.parse(
                                            timeYearController.text));
                                setState(() {
                                  rate = csi.getRate2();
                                });
                              } else if (optionAnnuity == 2) {
                                csi.calculateTime(
                                    principal:
                                        double.parse(principalController.text),
                                    rate: double.parse(rateController.text),
                                    amount:
                                        double.parse(amountController.text));
                                setState(() {
                                  time = csi.getTime();
                                });
                              } else if (optionAnnuity == 3) {
                                csi.calculatePrincipal(
                                    amount: double.parse(amountController.text),
                                    rate: double.parse(rateController.text),
                                    timeDay: timeDayController.text.isEmpty
                                        ? 0
                                        : double.parse(timeDayController.text),
                                    timeMonth: timeMonthController.text.isEmpty
                                        ? 0
                                        : double.parse(
                                            timeMonthController.text),
                                    timeYear: timeYearController.text.isEmpty
                                        ? 0
                                        : double.parse(
                                            timeYearController.text));
                                setState(() {
                                  principal = csi.getPrincipal();
                                });
                              } else if (optionAnnuity == 4) {
                                csi.calculateInterest(
                                    principal:
                                        double.parse(principalController.text),
                                    amount:
                                        double.parse(amountController.text));
                                setState(() {
                                  interest = csi.getSimpleInterest();
                                });
                              }
                              csi.clearValues();
                            }
                          },
                          child: const Text('Calcular'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        optionAnnuity == 0 && interest != 0 && amount != 0
                            ? SimpleInterestAmountResult(
                                interest: interest, amount: amount)
                            : const SizedBox(),
                        optionAnnuity == 1 && rate != 0
                            ? Text('Tasa de Interes: $rate %',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                            : const SizedBox(),
                        optionAnnuity == 2 && time != 0
                            ? Text('Tiempo: $time años',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                            : const SizedBox(),
                        optionAnnuity == 3 && principal != 0
                            ? Text('Capital Inicial: $principal',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                            : const SizedBox(),
                        optionAnnuity == 4 && interest != 0
                            ? Text('Interes Simple: $interest',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                            : const SizedBox(),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}

class SimpleInterestAmountResult extends StatelessWidget {
  const SimpleInterestAmountResult({
    super.key,
    required this.interest,
    required this.amount,
  });

  final double? interest;
  final double? amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText('Interes Simple: $interest',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SelectableText('Monto: $amount',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class Time extends StatelessWidget {
  const Time({
    super.key,
    required this.timeYearController,
    required this.timeMonthController,
    required this.timeDayController,
  });

  final TextEditingController timeYearController;
  final TextEditingController timeMonthController;
  final TextEditingController timeDayController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text('Tiempo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          controller: timeYearController,
          decoration: const InputDecoration(
            labelText: 'Años',
          ),
          keyboardType: TextInputType.number,
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
      ],
    );
  }
}
