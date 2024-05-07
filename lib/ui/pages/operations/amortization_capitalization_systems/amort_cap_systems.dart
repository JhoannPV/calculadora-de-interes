import 'package:calculadora_de_interes/ui/pages/home/drawer.dart';
import 'package:calculadora_de_interes/ui/pages/operations/amortization_capitalization_systems/amort_systems.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AmortCapSystems extends StatefulWidget {
  const AmortCapSystems({super.key});

  @override
  State<AmortCapSystems> createState() => _AmortCapSystemsState();
}

class _AmortCapSystemsState extends State<AmortCapSystems> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController deudaInicialController = TextEditingController();
  TextEditingController tasaInteresController = TextEditingController();
  TextEditingController cuotasController = TextEditingController();
  int optionTypeAmort = 0;
  bool isCalculated = false;

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
    deudaInicialController.dispose();
    tasaInteresController.dispose();
    cuotasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistemas de Amortización y Capitalización'),
        backgroundColor: const Color(0xFF013542),
        foregroundColor: Colors.white,
      ),
      endDrawer: const DrawerMenu(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const ExpansionTile(
              title: Text('¿Qué es Amortización y Capitalización?'),
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      'La amortización se entiende como el proceso de cancelar una obligación a través de pagos periódicos que pueden ser iguales o diferentes, es común que se apliquen diferentes sistemas de amortización en el mercado financiero. La capitalización, por su parte, es el proceso de reunir un capital a través de pagos (cuotas) periódicos que pueden, igualmente, ser iguales o diferentes; también existen diferentes sistemas de capitalización.\nAunque los sistemas de amortización pueden ser diversos, todos ellos corresponden o son variantes del sistema alemán, el francés o el americano. El sistema alemán conocido como pagos con abonos iguales a capital; el francés como amortización con cuotas iguales y el sistema americano como pago único de capital con abonos periódicos de interés. '),
                ),
                SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 20),
            ExpansionTile(
              title: const Text('Fórmula'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getFormula(optionTypeAmort),
                ),
              ],
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 30,
                onPageChanged: (index, reason) {
                  setState(() {
                    optionTypeAmort = index;
                  });
                },
              ),
              items: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_left),
                    Text('Sistema Francés',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_right),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_left),
                    Text('Sistema Alemán',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_right),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_left),
                    Text('Sistema Americano',
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
            Form(
                key: _keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: deudaInicialController,
                      decoration: const InputDecoration(
                        labelText: 'Deuda Inicial',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese la deuda inicial';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: tasaInteresController,
                      decoration: const InputDecoration(
                        labelText: 'Tasa de Interés (%)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese la tasa de interés (%)';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: cuotasController,
                      decoration: const InputDecoration(
                        labelText: 'Número de Cuotas',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el número de cuotas';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Frecuencia',
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isCalculated == true
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF013542)),
                                    onPressed: () {
                                      if (_keyForm.currentState!.validate()) {
                                        setState(() {
                                          isCalculated = true;
                                        });
                                      }
                                    },
                                    child: const Text('Calcular',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                          isCalculated == false
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF013542)),
                                    onPressed: () {
                                      setState(() {
                                        isCalculated = false;
                                      });
                                    },
                                    child: const Text('Ocultar',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (isCalculated)
                      Column(
                        children: [
                          optionTypeAmort == 0 && isCalculated
                              ? SistemaFrances(
                                  deudaInicial:
                                      double.parse(deudaInicialController.text),
                                  tasaInteres:
                                      double.parse(tasaInteresController.text),
                                  typeofinterest: selectedTypeofinterest,
                                  cuotas: int.parse(cuotasController.text),
                                )
                              : optionTypeAmort == 1 && isCalculated
                                  ? SistemaAleman(
                                      deudaInicial: double.parse(
                                          deudaInicialController.text),
                                      tasaInteres: double.parse(
                                          tasaInteresController.text),
                                      typeofinterest: selectedTypeofinterest,
                                      cuotas: int.parse(cuotasController.text),
                                    )
                                  : optionTypeAmort == 2 && isCalculated
                                      ? SistemaAmericano(
                                          deudaInicial: double.parse(
                                              deudaInicialController.text),
                                          tasaInteres: double.parse(
                                              tasaInteresController.text),
                                          typeofinterest:
                                              selectedTypeofinterest,
                                          cuotas:
                                              int.parse(cuotasController.text),
                                        )
                                      : const SizedBox(),
                        ],
                      ),
                  ],
                ))
          ],
        ),
      )),
    );
  }

  Widget getFormula(int optionTypeAmort) {
    switch (optionTypeAmort) {
      case 0:
        return Column(
          children: [
            const Text('Sistema Francés',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Image.asset('assets/formula/SistemaFrances.png'),
          ],
        );
      case 1:
        return Column(
          children: [
            const Text('Sistema Alemán',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Image.asset('assets/formula/SistemaAleman.png'),
          ],
        );
      case 2:
        return Column(
          children: [
            const Text('Sistema Americano',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Image.asset('assets/formula/SistemaAmericano.png'),
          ],
        );
      default:
        return const SizedBox(); // Retorna un widget vacío si la opción no es válida
    }
  }
}
