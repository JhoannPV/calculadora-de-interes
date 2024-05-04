import 'package:calculadora_de_interes/domain/controller/calculations/calculate_gradients.dart';
import 'package:calculadora_de_interes/ui/pages/widgets/business_days.dart';
import 'package:calculadora_de_interes/ui/pages/widgets/time_form.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Gradients extends StatefulWidget {
  const Gradients({super.key});

  @override
  State<Gradients> createState() => _GradientsState();
}

class _GradientsState extends State<Gradients> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController constantValueController = TextEditingController();
  TextEditingController gradientValueLController = TextEditingController();
  TextEditingController gradientValueGController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeDayController = TextEditingController();
  TextEditingController timeMonthController = TextEditingController();
  TextEditingController timeYearController = TextEditingController();
  CalculateGradients cg = Get.find();
  double? result = 0.0;
  int? switchVFVPC = 0;
  int optionGradients = 0;
  int optionTypeGradient = 0;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradients'),
        backgroundColor: const Color(0xFF013542),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: const BusinessDays(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const ExpansionTile(
                title: Text('¿Que son los Gradientes?'),
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        'Se conocen como Series Variables o Gradientes, los pagos que presentan un comportamiento creciente o decreciente de manera constante. También son llamados “Gradiente Aritmético” si la variación es periódica y lineal y “Gradiente Geométrico” si la variación es periódica y porcentual. '),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                title: const Text('Fórmula'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getFormula(optionGradients, optionTypeGradient),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: 30,
                  onPageChanged: (index, reason) {
                    setState(() {
                      optionGradients = index;
                    });
                  },
                ),
                items: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_left),
                      Text('Gradiente Lineal',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_left),
                      Text('Gradiente Geométrico',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
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
              CarouselSlider(
                options: CarouselOptions(
                  height: 30,
                  onPageChanged: (index, reason) {
                    setState(() {
                      optionTypeGradient = index;
                    });
                  },
                ),
                items: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_left),
                      Text('Creciente',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_left),
                      Text('Decreciente',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
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
              Form(
                  key: _keyForm,
                  child: Column(children: [
                    TextFormField(
                      controller: constantValueController,
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
                    optionGradients == 1
                        ? const SizedBox()
                        : TextFormField(
                            controller: gradientValueLController,
                            decoration: const InputDecoration(
                              labelText: 'Gradiente Lineal',
                              icon: Icon(Icons.trending_up),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Digite el valor del Gradiente Lineal';
                              }
                              return null;
                            },
                          ),
                    optionGradients == 0
                        ? const SizedBox()
                        : TextFormField(
                            controller: gradientValueGController,
                            decoration: const InputDecoration(
                              labelText: 'Gradiente Geometrico (%)',
                              icon: Icon(Icons.trending_up),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Digite el valor del Gradiente Geometrico';
                              }
                              return null;
                            },
                          ),
                    TextFormField(
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
                    Padding(
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
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Time(
                        title: 'Tiempo',
                        yearController: timeYearController,
                        monthController: timeMonthController,
                        dayController: timeDayController),
                  ])),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF013542)),
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            if (optionGradients == 0 &&
                                optionTypeGradient == 0) {
                              cg.calculateIncreasingLinearGradientVF(
                                  constantValue: double.parse(
                                      constantValueController.text),
                                  gradientValueL: double.parse(
                                      gradientValueLController.text),
                                  rate: double.parse(rateController.text),
                                  typeofinterest: selectedTypeofinterest,
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
                                result = cg.getFutureValue();
                                switchVFVPC = 0;
                              });
                              cg.clearValues();
                            } else if (optionGradients == 0 &&
                                optionTypeGradient == 1) {
                              cg.calculateDecreasingLinearGradientVF(
                                  constantValue: double.parse(
                                      constantValueController.text),
                                  gradientValueL: double.parse(
                                      gradientValueLController.text),
                                  rate: double.parse(rateController.text),
                                  typeofinterest: selectedTypeofinterest,
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
                                result = cg.getFutureValue();
                                switchVFVPC = 0;
                              });
                              cg.clearValues();
                            } else if (optionGradients == 1 &&
                                optionTypeGradient == 0) {
                              cg.calculateIncreasingGeometricGradientVF(
                                constantValue:
                                    double.parse(constantValueController.text),
                                gradientValueG:
                                    double.parse(gradientValueGController.text),
                                rate: double.parse(rateController.text),
                                typeofinterest: selectedTypeofinterest,
                                timeDay: timeDayController.text.isEmpty
                                    ? 0
                                    : double.parse(timeDayController.text),
                                timeMonth: timeMonthController.text.isEmpty
                                    ? 0
                                    : double.parse(timeMonthController.text),
                                timeYear: timeYearController.text.isEmpty
                                    ? 0
                                    : double.parse(timeYearController.text),
                              );
                              setState(() {
                                result = cg.getFutureValue();
                                switchVFVPC = 0;
                              });
                              cg.clearValues();
                            } else if (optionGradients == 1 &&
                                optionTypeGradient == 1) {
                              cg.calculateDecreasingGeometricGradientVF(
                                constantValue:
                                    double.parse(constantValueController.text),
                                gradientValueG:
                                    double.parse(gradientValueGController.text),
                                rate: double.parse(rateController.text),
                                typeofinterest: selectedTypeofinterest,
                                timeDay: timeDayController.text.isEmpty
                                    ? 0
                                    : double.parse(timeDayController.text),
                                timeMonth: timeMonthController.text.isEmpty
                                    ? 0
                                    : double.parse(timeMonthController.text),
                                timeYear: timeYearController.text.isEmpty
                                    ? 0
                                    : double.parse(timeYearController.text),
                              );
                              setState(() {
                                result = cg.getFutureValue();
                                switchVFVPC = 0;
                              });
                              cg.clearValues();
                            }
                          }
                        },
                        child: const Text('Calcular Valor Futuro',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF013542)),
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            if (optionGradients == 0 &&
                                optionTypeGradient == 0) {
                              cg.calculateIncreasingLinearGradientVP(
                                  constantValue: double.parse(
                                      constantValueController.text),
                                  gradientValueL: double.parse(
                                      gradientValueLController.text),
                                  rate: double.parse(rateController.text),
                                  typeofinterest: selectedTypeofinterest,
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
                                result = cg.getPresentValue();
                                switchVFVPC = 1;
                              });
                              cg.clearValues();
                            } else if (optionGradients == 0 &&
                                optionTypeGradient == 1) {
                              cg.calculateDecreasingLinearGradientVP(
                                  constantValue: double.parse(
                                      constantValueController.text),
                                  gradientValueL: double.parse(
                                      gradientValueLController.text),
                                  rate: double.parse(rateController.text),
                                  typeofinterest: selectedTypeofinterest,
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
                                result = cg.getPresentValue();
                                switchVFVPC = 1;
                              });
                              cg.clearValues();
                            } else if (optionGradients == 1 &&
                                optionTypeGradient == 0) {
                              cg.calculateIncreasingGeometricGradientVP(
                                constantValue:
                                    double.parse(constantValueController.text),
                                gradientValueG:
                                    double.parse(gradientValueGController.text),
                                rate: double.parse(rateController.text),
                                typeofinterest: selectedTypeofinterest,
                                timeDay: timeDayController.text.isEmpty
                                    ? 0
                                    : double.parse(timeDayController.text),
                                timeMonth: timeMonthController.text.isEmpty
                                    ? 0
                                    : double.parse(timeMonthController.text),
                                timeYear: timeYearController.text.isEmpty
                                    ? 0
                                    : double.parse(timeYearController.text),
                              );
                              setState(() {
                                result = cg.getPresentValue();
                                switchVFVPC = 1;
                              });
                              cg.clearValues();
                            } else if (optionGradients == 1 &&
                                optionTypeGradient == 1) {
                              cg.calculateDecreasingGeometricGradientVP(
                                constantValue:
                                    double.parse(constantValueController.text),
                                gradientValueG:
                                    double.parse(gradientValueGController.text),
                                rate: double.parse(rateController.text),
                                typeofinterest: selectedTypeofinterest,
                                timeDay: timeDayController.text.isEmpty
                                    ? 0
                                    : double.parse(timeDayController.text),
                                timeMonth: timeMonthController.text.isEmpty
                                    ? 0
                                    : double.parse(timeMonthController.text),
                                timeYear: timeYearController.text.isEmpty
                                    ? 0
                                    : double.parse(timeYearController.text),
                              );
                              setState(() {
                                result = cg.getPresentValue();
                                switchVFVPC = 1;
                              });
                              cg.clearValues();
                            }
                          }
                        },
                        child: const Text('Calcular Valor Presente',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF013542)),
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          if (optionGradients == 0 && optionTypeGradient == 0) {
                            cg.calculateIncreasingLinearGradientQuota(
                              constantValue:
                                  double.parse(constantValueController.text),
                              gradientValueL:
                                  double.parse(gradientValueLController.text),
                              typeofinterest: selectedTypeofinterest,
                              timeDay: timeDayController.text.isEmpty
                                  ? 0
                                  : double.parse(timeDayController.text),
                              timeMonth: timeMonthController.text.isEmpty
                                  ? 0
                                  : double.parse(timeMonthController.text),
                              timeYear: timeYearController.text.isEmpty
                                  ? 0
                                  : double.parse(timeYearController.text),
                            );
                            setState(() {
                              result = cg.getQuotaValue();
                              switchVFVPC = 2;
                            });
                            cg.clearValues();
                          } else if (optionGradients == 0 &&
                              optionTypeGradient == 1) {
                            cg.calculateDecreasingLinearGradientQuota(
                              constantValue:
                                  double.parse(constantValueController.text),
                              gradientValueL:
                                  double.parse(gradientValueLController.text),
                              typeofinterest: selectedTypeofinterest,
                              timeDay: timeDayController.text.isEmpty
                                  ? 0
                                  : double.parse(timeDayController.text),
                              timeMonth: timeMonthController.text.isEmpty
                                  ? 0
                                  : double.parse(timeMonthController.text),
                              timeYear: timeYearController.text.isEmpty
                                  ? 0
                                  : double.parse(timeYearController.text),
                            );
                            setState(() {
                              result = cg.getQuotaValue();
                              switchVFVPC = 2;
                            });
                            cg.clearValues();
                          } else if (optionGradients == 1 &&
                              optionTypeGradient == 0) {
                            cg.calculateIncreasingGeometricGradientQuota(
                              constantValue:
                                  double.parse(constantValueController.text),
                              gradientValueG:
                                  double.parse(gradientValueGController.text),
                              typeofinterest: selectedTypeofinterest,
                              timeDay: timeDayController.text.isEmpty
                                  ? 0
                                  : double.parse(timeDayController.text),
                              timeMonth: timeMonthController.text.isEmpty
                                  ? 0
                                  : double.parse(timeMonthController.text),
                              timeYear: timeYearController.text.isEmpty
                                  ? 0
                                  : double.parse(timeYearController.text),
                            );
                            setState(() {
                              result = cg.getQuotaValue();
                              switchVFVPC = 2;
                            });
                            cg.clearValues();
                          } else if (optionGradients == 1 &&
                              optionTypeGradient == 1) {
                            cg.calculateDecreasingGeometricGradientQuota(
                              constantValue:
                                  double.parse(constantValueController.text),
                              gradientValueG:
                                  double.parse(gradientValueGController.text),
                              typeofinterest: selectedTypeofinterest,
                              timeDay: timeDayController.text.isEmpty
                                  ? 0
                                  : double.parse(timeDayController.text),
                              timeMonth: timeMonthController.text.isEmpty
                                  ? 0
                                  : double.parse(timeMonthController.text),
                              timeYear: timeYearController.text.isEmpty
                                  ? 0
                                  : double.parse(timeYearController.text),
                            );
                            setState(() {
                              result = cg.getQuotaValue();
                              switchVFVPC = 2;
                            });
                            cg.clearValues();
                          }
                        }
                      },
                      child: const Text('Calcular Cuota',
                          style: TextStyle(color: Colors.white)),
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
                              switchVFVPC == 0
                                  ? 'Valor Futuro: $result'
                                  : switchVFVPC == 1
                                      ? 'Valor Presente: $result'
                                      : 'Cuota: $result',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFormula(int optionGradients, int optionTypeGradient) {
    switch (optionGradients) {
      case 0:
        return optionTypeGradient == 0
            ? Column(
                children: [
                  const Text('Gradiente Lineal Creciente',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Image.asset('assets/formula/GradienteLinealCrecienteVF.png'),
                  Image.asset('assets/formula/GradienteLinealCrecienteVP.png'),
                  Image.asset(
                      'assets/formula/CuotaGradienteLinealCreciente.png')
                ],
              )
            : Column(
                children: [
                  const Text('Gradiente Lineal Decreciente',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Image.asset(
                      'assets/formula/GradienteLinealDecrecienteVF.png'),
                  Image.asset(
                      'assets/formula/GradienteLinealDecrecienteVP.png'),
                  Image.asset(
                      'assets/formula/CuotaGradienteLinealDecreciente.png')
                ],
              );
      case 1:
        return optionTypeGradient == 0
            ? Column(
                children: [
                  const Text('Gradiente Geométrico Creciente',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Image.asset(
                      'assets/formula/GradienteGeometricoCrecienteVF.png'),
                  Image.asset(
                      'assets/formula/GradienteGeometricoCrecienteVP.png'),
                  Image.asset(
                      'assets/formula/CuotaGradienteGeometricoCreciente.png')
                ],
              )
            : Column(
                children: [
                  const Text('Gradiente Geométrico Decreciente',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Image.asset(
                      'assets/formula/GradienteGeometricoDecrecienteVF.png'),
                  Image.asset(
                      'assets/formula/GradienteGeometricoDecrecienteVP.png'),
                  Image.asset(
                      'assets/formula/CuotaGradienteGeometricoDecreciente.png')
                ],
              );
      default:
        return const SizedBox(); // Retorna un widget vacío si la opción no es válida
    }
  }
}
