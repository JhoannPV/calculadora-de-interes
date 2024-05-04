import 'dart:math';
import 'package:calculadora_de_interes/ui/pages/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestReturn extends StatefulWidget {
  const InterestReturn({super.key});

  @override
  State<InterestReturn> createState() => _InterestReturnState();
}

class _InterestReturnState extends State<InterestReturn> {
  TextEditingController initialInvestmentController = TextEditingController();
  TextEditingController yearsController = TextEditingController();

  double tirEstimate = 0.0;
  bool showFields = false;
  List<TextEditingController> cashFlowControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retorno de interés'),
        backgroundColor: const Color(0xFF013542),
        foregroundColor: Colors.white,
      ),
      endDrawer: const DrawerMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const ExpansionTile(
              title: Text('¿Qué es el Retorno de interés?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                    'El retorno de interés es una medida que indica cuánto dinero se gana o se pierde en una inversión en relación con la cantidad de dinero invertido. Se expresa generalmente como un porcentaje y puede calcularse para diferentes periodos de tiempo, como anual, mensual o diario.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Fórmula'),
              children: <Widget>[
                ListTile(
                  title: getFormulaImage(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: initialInvestmentController,
              decoration: const InputDecoration(
                labelText: 'Inversión inicial',
                hintText: 'Ingresar la inversión inicial',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: yearsController,
              decoration: const InputDecoration(
                labelText: 'Años',
                hintText: 'Ingresar el número de años',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  int years = int.tryParse(value) ?? 0;
                  showFields = years > 0;
                  cashFlowControllers = List.generate(
                    years,
                    (index) => TextEditingController(),
                  );
                });
              },
            ),
            if (showFields)
              ...cashFlowControllers.map(
                (controller) => TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Flujo de efectivo',
                    hintText: 'Ingresar el flujo de efectivo',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                try {
                  double initialInvestment = -double.parse(
                      initialInvestmentController
                          .text); // Inversión inicial como un desembolso
                  List<double> cashFlows = [initialInvestment];
                  cashFlows.addAll(cashFlowControllers
                      .map((controller) => double.parse(controller.text))
                      .toList());
                  setState(() {
                    tirEstimate = calculateIRR(cashFlows);
                  });
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'No se pudo calcular la TIR. Por favor, revisa los flujos de efectivo ingresados.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 16),
            Text(
              'Tasa de retorno de interés: ${tirEstimate.ceil()}%',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFormulaImage() {
    return Image.asset(
      'assets/formula/TIR_tasa_interna_retorno.jpg', // Corregir el nombre de la imagen si es necesario
      width: 300,
      height: 200,
    );
  }

  double calculateIRR(List<double> cashFlows) {
    double tirEstimate = 0.01; // Estimación inicial de la TIR más conservadora
    const int maxIterations = 10000;
    const double tolerance = 1e-4;
    double van = 0;
    double vanDerivative = 0;

    for (int iteration = 0; iteration < maxIterations; iteration++) {
      van = 0;
      vanDerivative = 0;

      for (int period = 0; period < cashFlows.length; period++) {
        double discountedCashFlow =
            cashFlows[period] / pow(1 + tirEstimate, period);
        van += discountedCashFlow;
        if (period > 0) {
          vanDerivative += -period * discountedCashFlow / (1 + tirEstimate);
        }
      }
      if (van.abs() <= tolerance) {
        break; // Convergencia alcanzada
      }
      double tirDelta = van / vanDerivative;
      tirEstimate -= tirDelta;

      if (tirEstimate.isNaN || tirEstimate.isInfinite) {
        throw Exception(
            'No se pudo calcular la TIR: el resultado no es un número válido.');
      }
    }
    return tirEstimate * 100;
  }
}
