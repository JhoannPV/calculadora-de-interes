import 'package:calculadora_de_interes/domain/controller/calculations/calculate_annuities.dart';
import 'package:calculadora_de_interes/ui/pages/widgets/business_days.dart';
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
  int selectedOption = 0;

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
          backgroundColor: const Color(0xFF013542),
          foregroundColor: Colors.white,
        ),
        floatingActionButton: const BusinessDays(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      const ExpansionTile(
                          title: Text('¿Qué es una Anualidad?'),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  'Una anualidad es un flujo de pagos iguales que se realizan a intervalos iguales de tiempo. Estos pagos pueden ser realizados al principio o al final del periodo.'),
                            ),
                          ]),
                      const SizedBox(height: 20),
                      ExpansionTile(title: const Text('Formula'), children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: getFormula(selectedOption),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 30,
                            onPageChanged: (index, reason) {
                              setState(() {
                                optionAnnuity = index;
                                selectedOption = index;
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
                          icon: Icon(Icons.monetization_on),
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
                      optionAnnuity == 3
                          ? const SizedBox()
                          : Time(
                              title: 'Tiempo',
                              yearController: timeYearController,
                              monthController: timeMonthController,
                              dayController: timeDayController),
                      optionAnnuity == 2
                          ? Time(
                              title: 'Diferido',
                              yearController: deferTimeYearController,
                              monthController: deferTimeMonthController,
                              dayController: deferTimeDayController)
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
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF013542)),
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
                                      child: const Text('Calcular Monto Final',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF013542)),
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
                                child: const Text('Calcular Valor Actual',
                                    style: TextStyle(color: Colors.white)),
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

Widget getFormula(int selectedOption) {
  switch (selectedOption) {
    case 0:
      return Column(
        children: [
          Image.asset('assets/formula/anualidad_ordinaria_vp.jpg'),
          Image.asset('assets/formula/anualidad_ordinaria_vf.jpg'),
        ],
      );
    case 1:
      return Column(
        children: [
          Image.asset('assets/formula/anualidad_anticipada_vp.jpg'),
          Image.asset('assets/formula/anualidad_anticipada_vf.jpg'),
        ],
      );
    case 2:
      return Column(
        children: [
          Image.asset('assets/formula/anualidad_diferida_vp.jpg'),
          Image.asset('assets/formula/anualidad_diferida_vf.jpg'),
        ],
      );
    case 3:
      return Image.asset('assets/formula/anualidad_perpetua_vp.jpg');
    default:
      return const SizedBox(); // Retorna un widget vacío si la opción no es válida
  }
}

class Time extends StatelessWidget {
  const Time({
    super.key,
    required this.title,
    required this.yearController,
    required this.monthController,
    required this.dayController,
  });
  final String title;
  final TextEditingController yearController;
  final TextEditingController monthController;
  final TextEditingController dayController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          controller: yearController,
          decoration: const InputDecoration(
            labelText: 'Años',
            icon: Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: monthController,
          decoration: const InputDecoration(
            labelText: 'Meses',
            icon: Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: dayController,
          decoration: const InputDecoration(
            labelText: 'Días',
            icon: Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
