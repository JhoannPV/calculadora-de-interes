import 'package:calculadora_de_interes/domain/controller/calculations/calculate_simple_interest.dart';
import 'package:calculadora_de_interes/ui/pages/home/drawer.dart';
import 'package:calculadora_de_interes/ui/pages/widgets/business_days.dart';
import 'package:calculadora_de_interes/ui/pages/widgets/time_form.dart';
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
  TextEditingController simpleInterestController = TextEditingController();
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
  int optionIntSimpleOp = 0;
  int selectedOption = 0;
  int optionAmountorInterestS = 0;
  List<String> typeofinterest = [
    'Mensual',
    'Bimestral',
    'Trimestral',
    'Cuatrimestral',
    'Semestral',
    'Anual'
  ];
  String selectedTypeofinterest = 'Anual';

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
          backgroundColor: const Color(0xFF013542),
          foregroundColor: Colors.white,
        ),
        drawer: const DrawerMenu(),
        floatingActionButton: const BusinessDays(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const ExpansionTile(
                  title: Text('¿Qué es el interés simple?'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          'El interes simple es el interes que se paga sobre el capital inicial durante un periodo de tiempo determinado. El interes simple se calcula multiplicando el capital inicial por la tasa de interes y el tiempo en años.'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text('Fórmula'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          getFormula(selectedOption, optionAmountorInterestS),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 30,
                    onPageChanged: (index, reason) {
                      setState(() {
                        optionIntSimpleOp = index;
                        selectedOption = index;
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
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      optionIntSimpleOp == 3
                          ? const SizedBox()
                          : TextFormField(
                              controller: principalController,
                              decoration: const InputDecoration(
                                labelText: 'Valor Presente o Capital Inicial',
                                icon: Icon(Icons.monetization_on),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Digite el valor del Capital Inicial';
                                }
                                return null;
                              },
                            ),
                      optionIntSimpleOp == 1 ||
                              optionIntSimpleOp == 2 ||
                              optionIntSimpleOp == 3
                          ? Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 30,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      optionAmountorInterestS = index;
                                    });
                                  },
                                ),
                                items: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_left),
                                      Text('Monto Final',
                                          style: TextStyle(fontSize: 17)),
                                      Icon(Icons.arrow_right),
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_left),
                                      Text('Interes Simple',
                                          style: TextStyle(fontSize: 17)),
                                      Icon(Icons.arrow_right),
                                    ],
                                  ),
                                ].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return i;
                                    },
                                  );
                                }).toList(),
                              ),
                            )
                          : const SizedBox(),
                      optionIntSimpleOp == 2 ||
                              optionIntSimpleOp == 1 ||
                              optionIntSimpleOp == 3
                          ? optionAmountorInterestS == 0
                              ? TextFormField(
                                  controller: amountController,
                                  decoration: const InputDecoration(
                                    labelText: 'Valor Futuro o Monto Final',
                                    icon: Icon(Icons.monetization_on),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Digite el valor del Monto Final';
                                    }
                                    return null;
                                  },
                                )
                              : TextFormField(
                                  controller: simpleInterestController,
                                  decoration: const InputDecoration(
                                    labelText: 'Interes Simple',
                                    icon: Icon(Icons.monetization_on_outlined),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Digite el valor del Interes Simple';
                                    }
                                    return null;
                                  },
                                )
                          : const SizedBox(),
                      optionIntSimpleOp == 4
                          ? TextFormField(
                              controller: amountController,
                              decoration: const InputDecoration(
                                labelText: 'Valor Futuro o Monto Final',
                                icon: Icon(Icons.monetization_on),
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
                      optionIntSimpleOp == 1 || optionIntSimpleOp == 4
                          ? const SizedBox()
                          : TextFormField(
                              controller: rateController,
                              decoration: const InputDecoration(
                                labelText: 'Tasa de Interes (%)',
                                icon: Icon(Icons.percent),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Digite el valor de la tasa';
                                }
                                return null;
                              },
                            ),
                      optionIntSimpleOp == 4
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Tipo de Interes',
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  DropdownButton<String>(
                                    value: selectedTypeofinterest,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTypeofinterest = newValue!;
                                      });
                                    },
                                    items: typeofinterest
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                      optionIntSimpleOp == 2 || optionIntSimpleOp == 4
                          ? const SizedBox()
                          : Time(
                              title: 'Tiempo',
                              yearController: timeYearController,
                              monthController: timeMonthController,
                              dayController: timeDayController),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF013542)),
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              if (optionIntSimpleOp == 0) {
                                csi.calculateSimpleInterest(
                                    principal:
                                        double.parse(principalController.text),
                                    rate: double.parse(rateController.text),
                                    typeofinterest: selectedTypeofinterest,
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
                              } else if (optionIntSimpleOp == 1) {
                                optionAmountorInterestS == 0
                                    ? csi.calculateRate(
                                        principal: double.parse(
                                            principalController.text),
                                        amount:
                                            double.parse(amountController.text),
                                        typeofinterest: selectedTypeofinterest,
                                        timeDay: timeDayController.text.isEmpty
                                            ? 0
                                            : double.parse(
                                                timeDayController.text),
                                        timeMonth:
                                            timeMonthController.text.isEmpty
                                                ? 0
                                                : double.parse(
                                                    timeMonthController.text),
                                        timeYear:
                                            timeYearController.text.isEmpty
                                                ? 0
                                                : double.parse(
                                                    timeYearController.text))
                                    : csi.calculateRate2(
                                        principal: double.parse(
                                            principalController.text),
                                        simpleInterest: double.parse(
                                            simpleInterestController.text),
                                        typeofinterest: selectedTypeofinterest,
                                        timeDay: timeDayController.text.isEmpty
                                            ? 0
                                            : double.parse(timeDayController.text),
                                        timeMonth: timeMonthController.text.isEmpty ? 0 : double.parse(timeMonthController.text),
                                        timeYear: timeYearController.text.isEmpty ? 0 : double.parse(timeYearController.text));
                                setState(() {
                                  rate = csi.getRate2();
                                });
                              } else if (optionIntSimpleOp == 2) {
                                optionAmountorInterestS == 0
                                    ? csi.calculateTime(
                                        principal: double.parse(
                                            principalController.text),
                                        rate: double.parse(rateController.text),
                                        amount:
                                            double.parse(amountController.text),
                                        typeofinterest: selectedTypeofinterest)
                                    : csi.calculateTime2(
                                        principal: double.parse(
                                            principalController.text),
                                        rate: double.parse(rateController.text),
                                        simpleInterest: double.parse(
                                            simpleInterestController.text),
                                        typeofinterest: selectedTypeofinterest);
                                setState(() {
                                  time = csi.getTime();
                                });
                              } else if (optionIntSimpleOp == 3) {
                                optionAmountorInterestS == 0
                                    ? csi.calculatePrincipal(
                                        amount:
                                            double.parse(amountController.text),
                                        typeofinterest: selectedTypeofinterest,
                                        rate: double.parse(rateController.text),
                                        timeDay: timeDayController.text.isEmpty
                                            ? 0
                                            : double.parse(
                                                timeDayController.text),
                                        timeMonth: timeMonthController.text.isEmpty
                                            ? 0
                                            : double.parse(
                                                timeMonthController.text),
                                        timeYear: timeYearController.text.isEmpty
                                            ? 0
                                            : double.parse(
                                                timeYearController.text))
                                    : csi.calculatePrincipal2(
                                        simpleInterest: double.parse(
                                            simpleInterestController.text),
                                        typeofinterest: selectedTypeofinterest,
                                        rate: double.parse(rateController.text),
                                        timeDay: timeDayController.text.isEmpty
                                            ? 0
                                            : double.parse(
                                                timeDayController.text),
                                        timeMonth: timeMonthController.text.isEmpty
                                            ? 0
                                            : double.parse(
                                                timeMonthController.text),
                                        timeYear:
                                            timeYearController.text.isEmpty ? 0 : double.parse(timeYearController.text));
                                setState(() {
                                  principal = csi.getPrincipal();
                                });
                              } else if (optionIntSimpleOp == 4) {
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
                          child: const Text('Calcular',
                              style: TextStyle(color: Colors.white)),
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
                        optionIntSimpleOp == 0 && interest != 0 && amount != 0
                            ? SimpleInterestAmountResult(
                                interest: interest, amount: amount)
                            : const SizedBox(),
                        optionIntSimpleOp == 1 && rate != 0
                            ? Text('Tasa de Interes: $rate %',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                            : const SizedBox(),
                        optionIntSimpleOp == 2 && time != 0
                            ? Text('Tiempo: $time años',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                            : const SizedBox(),
                        optionIntSimpleOp == 3 && principal != 0
                            ? Text('Capital Inicial: $principal',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                            : const SizedBox(),
                        optionIntSimpleOp == 4 && interest != 0
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

  Widget getFormula(int selectedOption, int optionAmountorInterestS) {
    switch (selectedOption) {
      case 0:
        return Column(
          children: [
            Image.asset('assets/formula/interesSimple.jpg', height: 80),
            Image.asset('assets/formula/MontoSimple.jpg', height: 80),
          ],
        );
      case 1:
        return optionAmountorInterestS == 0
            ? Image.asset('assets/formula/TasaInteresSimple.jpg')
            : Image.asset('assets/formula/TasaInteresSimple2.jpg');
      case 2:
        return optionAmountorInterestS == 0
            ? Image.asset('assets/formula/TiempoSimple.jpg')
            : Image.asset('assets/formula/TiempoSimple2.jpg');
      case 3:
        return optionAmountorInterestS == 0
            ? Image.asset('assets/formula/ValorPreSimple.jpg')
            : Image.asset('assets/formula/ValorPreSimple2.jpg');
      case 4:
        return Image.asset('assets/formula/InteresSimple=valorF.jpg');

      default:
        return const SizedBox(); // Retorna un widget vacío si la opción no es válida
    }
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
