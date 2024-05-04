import 'dart:math';
import 'package:flutter/material.dart';

class InterestReturn extends StatefulWidget {
  const InterestReturn({super.key});

  @override
  State<InterestReturn> createState() => _InterestReturnState();
}

class _InterestReturnState extends State<InterestReturn> {
  TextEditingController initialInvestmentController = TextEditingController();
  TextEditingController cashFlowController = TextEditingController();
  TextEditingController yearsController = TextEditingController();

  double tir = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retorno de interés'),
        backgroundColor: const Color(0xFF013542),
        foregroundColor: Colors.white,
      ),
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
              controller: cashFlowController,
              decoration: const InputDecoration(
                labelText: 'Flujo de efectivo',
                hintText: 'Ingresar el flujo de efectivo',
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
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateTIR,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 16),
            Text(
              'Tasa de retorno de interés: ${tir.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFormulaImage() {
    return Image.asset(
      'assets/images/interest_returne_formula.png',
      width: 300,
      height: 200,
    );
  }

  void calculateTIR() {
    double initialInvestment =
        double.tryParse(initialInvestmentController.text) ?? 0.0;
    double cashFlow = double.tryParse(cashFlowController.text) ?? 0.0;
    int years = int.tryParse(yearsController.text) ?? 0;

    double tir = calculateTIRFormula(initialInvestment, cashFlow, years);

    setState(() {
      this.tir = tir;
    });
  }

  double calculateTIRFormula(
      double initialInvestment, double cashFlow, int years) {
    double low = -0.99;
    double high = 0.99;

    double tolerance = 0.00001;

    double tir = (low + high) / 2.0;
    double npv = calculateNPV(initialInvestment, cashFlow, years, tir);

    while ((high - low).abs() > tolerance) {
      if (npv == 0) {
        break;
      } else if (npv > 0) {
        high = tir;
      } else {
        low = tir;
      }
      tir = (low + high) / 2.0;
      npv = calculateNPV(initialInvestment, cashFlow, years, tir);
    }

    return tir * 100.0; // Convertir a porcentaje
  }

  double calculateNPV(
      double initialInvestment, double cashFlow, int years, double rate) {
    double npv = -initialInvestment;
    for (int n = 1; n <= years; n++) {
      npv += cashFlow / pow(1 + rate, n);
    }
    return npv;
  }
}
