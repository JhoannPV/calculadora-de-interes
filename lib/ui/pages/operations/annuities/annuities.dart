import 'package:calculadora_de_interes/domain/controller/calculations/calculate_annuities.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Annuities extends StatefulWidget {
  const Annuities({super.key});

  @override
  State<Annuities> createState() => _AnnuitiesState();
}

class _AnnuitiesState extends State<Annuities> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController annuityController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeDayController = TextEditingController();
  TextEditingController timeMonthController = TextEditingController();
  TextEditingController timeYearController = TextEditingController();
  TextEditingController deferTimeDayController = TextEditingController();
  TextEditingController deferTimeMonthController = TextEditingController();
  TextEditingController deferTimeYearController = TextEditingController();
  CalculateAnnuities ca = Get.find();
  double? result = 0.0;
  bool? switchVFVA = false;
  int optionAnnuity = 0;

  @override
  void dispose() {
    annuityController.dispose();
    rateController.dispose();
    timeDayController.dispose();
    timeMonthController.dispose();
    timeYearController.dispose();
    deferTimeDayController.dispose();
    deferTimeMonthController.dispose();
    deferTimeYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Anualidades'),
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
                                Text('Anualidad Ordinaria o Vencida',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_left),
                                Text('Anualidad Anticipada',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_left),
                                Text('Anualidad Diferida',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_left),
                                Text('Anualidad Perpetua',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
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
                      TextFormField(
                        controller: annuityController,
                        decoration: const InputDecoration(
                          labelText: 'Anualidad',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Digite el valor del Anualidad';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
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
                      optionAnnuity == 3
                          ? const SizedBox()
                          : Time(
                              timeYearController: timeYearController,
                              timeMonthController: timeMonthController,
                              timeDayController: timeDayController),
                      optionAnnuity == 2
                          ? Diferred(
                              deferTimeYearController: deferTimeYearController,
                              deferTimeMonthController:
                                  deferTimeMonthController,
                              deferTimeDayController: deferTimeDayController)
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            optionAnnuity == 3
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_keyForm.currentState!.validate()) {
                                          if (optionAnnuity == 0) {
                                            ca.calculateOrdinaryAnnuityVF(
                                                annuity: double.parse(
                                                    annuityController.text),
                                                rate: double.parse(
                                                    rateController.text),
                                                timeDay: timeDayController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        timeDayController.text),
                                                timeMonth:
                                                    timeMonthController.text.isEmpty
                                                        ? 0
                                                        : double.parse(
                                                            timeMonthController
                                                                .text),
                                                timeYear: timeYearController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        timeYearController.text));
                                            setState(() {
                                              result = ca.getAmount();
                                              switchVFVA = false;
                                            });
                                            ca.clearValues();
                                          } else if (optionAnnuity == 1) {
                                            ca.calculateAdvanceAnnuityVF(
                                                annuity: double.parse(
                                                    annuityController.text),
                                                rate: double.parse(
                                                    rateController.text),
                                                timeDay: timeDayController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        timeDayController.text),
                                                timeMonth:
                                                    timeMonthController.text.isEmpty
                                                        ? 0
                                                        : double.parse(
                                                            timeMonthController
                                                                .text),
                                                timeYear: timeYearController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        timeYearController.text));
                                            setState(() {
                                              result = ca.getAmount();
                                              switchVFVA = false;
                                            });
                                            ca.clearValues();
                                          } else if (optionAnnuity == 2) {
                                            ca.calculateDeferredAnnuityVF(
                                              annuity: double.parse(
                                                  annuityController.text),
                                              rate: double.parse(
                                                  rateController.text),
                                              timeDay: timeDayController
                                                      .text.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      timeDayController.text),
                                              timeMonth: timeMonthController
                                                      .text.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      timeMonthController.text),
                                              timeYear: timeYearController
                                                      .text.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      timeYearController.text),
                                              deferTimeDay:
                                                  deferTimeDayController
                                                          .text.isEmpty
                                                      ? 0
                                                      : double.parse(
                                                          deferTimeDayController
                                                              .text),
                                              deferTimeMonth:
                                                  deferTimeMonthController
                                                          .text.isEmpty
                                                      ? 0
                                                      : double.parse(
                                                          deferTimeMonthController
                                                              .text),
                                              deferTimeYear:
                                                  deferTimeYearController
                                                          .text.isEmpty
                                                      ? 0
                                                      : double.parse(
                                                          deferTimeYearController
                                                              .text),
                                            );
                                            setState(() {
                                              result = ca.getAmount();
                                              switchVFVA = false;
                                            });
                                            ca.clearValues();
                                          }
                                        }
                                      },
                                      child: const Text('Calcular Monto Final'),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_keyForm.currentState!.validate()) {
                                    if (optionAnnuity == 0) {
                                      ca.calculateOrdinaryAnnuityVA(
                                          annuity: double.parse(
                                              annuityController.text),
                                          rate:
                                              double.parse(rateController.text),
                                          timeDay:
                                              timeDayController.text.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      timeDayController.text),
                                          timeMonth:
                                              timeMonthController.text.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      timeMonthController.text),
                                          timeYear: timeYearController
                                                  .text.isEmpty
                                              ? 0
                                              : double.parse(
                                                  timeYearController.text));
                                      setState(() {
                                        result = ca.getPrincipal();
                                        switchVFVA = true;
                                      });
                                      ca.clearValues();
                                    } else if (optionAnnuity == 1) {
                                      ca.calculateAdvanceAnnuityVA(
                                          annuity: double.parse(
                                              annuityController.text),
                                          rate:
                                              double.parse(rateController.text),
                                          timeDay:
                                              timeDayController.text.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      timeDayController.text),
                                          timeMonth:
                                              timeMonthController.text.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      timeMonthController.text),
                                          timeYear: timeYearController
                                                  .text.isEmpty
                                              ? 0
                                              : double.parse(
                                                  timeYearController.text));
                                      setState(() {
                                        result = ca.getPrincipal();
                                        switchVFVA = true;
                                      });
                                      ca.clearValues();
                                    } else if (optionAnnuity == 2) {
                                      ca.calculateDeferredAnnuityVA(
                                        annuity: double.parse(
                                            annuityController.text),
                                        rate: double.parse(rateController.text),
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
                                                    timeYearController.text),
                                        deferTimeDay: deferTimeDayController
                                                .text.isEmpty
                                            ? 0
                                            : double.parse(
                                                deferTimeDayController.text),
                                        deferTimeMonth: deferTimeMonthController
                                                .text.isEmpty
                                            ? 0
                                            : double.parse(
                                                deferTimeMonthController.text),
                                        deferTimeYear: deferTimeYearController
                                                .text.isEmpty
                                            ? 0
                                            : double.parse(
                                                deferTimeYearController.text),
                                      );
                                      setState(() {
                                        result = ca.getPrincipal();
                                        switchVFVA = true;
                                      });
                                      ca.clearValues();
                                    } else if (optionAnnuity == 3) {
                                      ca.calculatePerpetualAnnuityVA(
                                          annuity: double.parse(
                                              annuityController.text),
                                          rate: double.parse(
                                              rateController.text));
                                      setState(() {
                                        result = ca.getAmount();
                                        switchVFVA = true;
                                      });
                                      ca.clearValues();
                                    }
                                  }
                                },
                                child: const Text('Calcular Valor Actual'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                result != 0
                    ? Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                                switchVFVA == false
                                    ? 'Monto: $result'
                                    : 'Valor Actual: $result',
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

class Diferred extends StatelessWidget {
  const Diferred({
    super.key,
    required this.deferTimeYearController,
    required this.deferTimeMonthController,
    required this.deferTimeDayController,
  });

  final TextEditingController deferTimeYearController;
  final TextEditingController deferTimeMonthController;
  final TextEditingController deferTimeDayController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text('Diferido',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          controller: deferTimeYearController,
          decoration: const InputDecoration(
            labelText: 'Años',
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: deferTimeMonthController,
          decoration: const InputDecoration(
            labelText: 'Meses',
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: deferTimeDayController,
          decoration: const InputDecoration(
            labelText: 'Días',
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
