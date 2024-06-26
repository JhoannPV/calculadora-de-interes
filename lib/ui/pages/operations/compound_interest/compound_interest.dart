import 'package:calculadora_de_interes/domain/controller/data/data.dart';
import 'package:calculadora_de_interes/ui/pages/home/drawer.dart';
import 'package:calculadora_de_interes/ui/pages/widgets/business_days.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class CompoundInterest extends StatefulWidget {
  const CompoundInterest({super.key});

  @override
  State<CompoundInterest> createState() => _CompoundInterestState();
}

class _CompoundInterestState extends State<CompoundInterest> {
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _finalAmountController = TextEditingController();
  Data data = Get.find();
  String _selectedTimeBase = 'Año'; // Valor inicial
  final List<String> _timeBases = ['Día', 'Mes', 'Año'];
  final List<String> _calculations = [
    'Interés Compuesto',
    'Capital Inicial',
    'Tiempo',
    'Tasa de Interés'
  ];

  String _selectedCalculation = 'Interés Compuesto';

  void _calculateCompoundInterest() {
    double principal = double.tryParse(_capitalController.text) ?? 0.0;
    double rate = double.tryParse(_interestRateController.text) ?? 0.0;
    double period = double.tryParse(_periodController.text) ?? 0.0;

    switch (_selectedTimeBase) {
      case 'Día':
        rate = rate / 100; // tasa anual a diaria
        period =
            period / data.getDays.value!.toDouble(); // periodo de días a años
        break;
      case 'Mes':
        rate = rate / 100; // tasa anual a mensual
        period = period / 12; // periodo de meses a años

        break;
      case 'Año':
        rate = rate / 100; // tasa de porcentaje a decimal
        break;
    }

    // Formula
    double finalAmount = principal * math.pow((1 + rate), period);

    // Mostrar el resultado
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text('Monto Compuesto: \$${finalAmount.toStringAsFixed(1)}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar',
                  style: TextStyle(color: Color(0xFF013542))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _calculateInitialCapital() {
    double finalAmount =
        double.tryParse(_finalAmountController.text) ?? 0.0; // A
    double rate = double.tryParse(_interestRateController.text) ?? 0.0; // i
    double period = double.tryParse(_periodController.text) ?? 0.0; // n

    switch (_selectedTimeBase) {
      case 'Día':
        rate = rate / 100; // tasa anual a diaria
        period =
            period / data.getDays.value!.toDouble(); // periodo de días a años
        break;
      case 'Mes':
        rate = rate / 100; // tasa anual a mensual
        period = period / 12; // periodo de meses a años

        break;
      case 'Año':
        rate = rate / 100; // tasa de porcentaje a decimal
        break;
    }

    // Formula
    double principal = finalAmount / math.pow((1 + rate), period);

    // Mostrar el resultado
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text(
              'Capital Inicial Requerido: \$${principal.toStringAsFixed(1)}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar',
                  style: TextStyle(color: Color(0xFF013542))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _calculateTime() {
    double principal = double.tryParse(_capitalController.text) ?? 0.0;
    double finalAmount = double.tryParse(_finalAmountController.text) ?? 0.0;
    double rate = double.tryParse(_interestRateController.text) ?? 0.0;

    switch (_selectedTimeBase) {
      case 'Día':
        rate = rate / 100; // tasa anual a diaria
        break;
      case 'Mes':
        rate = rate / 100; // tasa anual a mensual
        break;
      case 'Año':
        rate = rate / 100; // tasa de porcentaje a decimal
        break;
    }

    // fórmula para calcular el tiempo
    double logMC = math.log(finalAmount);
    double logC = math.log(principal);
    double logRate = math.log(1 + rate);

    double time = (logMC - logC) / logRate;

    switch (_selectedTimeBase) {
      case 'Día':
        if (_selectedTimeBase == 'mes') {
          time *= 30; // Convertir días a meses (asumiendo un mes de 30 días)
        } else {
          time *= data.getDays.value!
              .toDouble(); // Convertir días a años (tomando en cuenta años bisiestos)
        }
        break;
      case 'Mes':
        if (_selectedTimeBase == 'día') {
          time /= 30; // Convertir meses a días (asumiendo un mes de 30 días)
        } else {
          time *= 12; // Convertir meses a años
        }
        break;
      case 'Año':
        break;
    }

    // Mostrar el resultado
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text(
              'Tiempo: ${time.toStringAsFixed(2)} ${_selectedTimeBase.toLowerCase()}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar',
                  style: TextStyle(color: Color(0xFF013542))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _calculateInterestRate() {
    double principal = double.tryParse(_capitalController.text) ?? 0.0;
    double finalAmount = double.tryParse(_finalAmountController.text) ?? 0.0;
    double period = double.tryParse(_periodController.text) ?? 0.0;

    switch (_selectedTimeBase) {
      case 'Día':
        period =
            period / data.getDays.value!.toDouble(); // periodo de días a años
        break;
      case 'Mes':
        period = period / 12; // periodo de meses a años
        break;
      case 'Año':
        break;
    }

    //  fórmula para calcular la tasa de interés
    double rate = math.pow(finalAmount / principal, 1 / period) - 1;

    // Mostrar el resultado
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text('Tasa de Interés: ${(rate * 100).toStringAsFixed(1)}%'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _capitalController.dispose();
    _interestRateController.dispose();
    _periodController.dispose();
    _finalAmountController.dispose();
    super.dispose();
  }

  Widget getFormulaImage() {
    String imagePath;
    switch (_selectedCalculation) {
      case 'Interés Compuesto':
        imagePath = 'assets/formula/MontoCompuesto.png';
        break;
      case 'Capital Inicial':
        imagePath = 'assets/formula/Capital_inicial.png';
        break;
      case 'Tiempo':
        imagePath = 'assets/formula/TiempoCompuesto.png';
        break;
      case 'Tasa de Interés':
        imagePath = 'assets/formula/TasaInteresCompuesto.png';
        break;
      default:
        imagePath =
            ''; // Considera definir una imagen por defecto o manejar este caso de manera adecuada
    }
    return imagePath.isNotEmpty
        ? Image.asset(imagePath)
        : Container(); // Retorna un Container vacío si no hay imagePath definido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interes Compuesto'),
        backgroundColor: const Color(0xFF013542),
        foregroundColor: Colors.white,
      ),
      endDrawer: const DrawerMenu(),
      floatingActionButton: const BusinessDays(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const ExpansionTile(
              title: Text('¿Qué es el Interés Compuesto?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                    'El interés compuesto se refiere al proceso de generar interés sobre el interés acumulado anteriormente, '
                    'además del principal durante un período de tiempo. Es una fuerza poderosa para el crecimiento del capital '
                    'ya que los intereses se calculan sobre el saldo acumulado del capital y los intereses previos, no solo '
                    'sobre el capital inicial.',
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
            if (_selectedCalculation !=
                'Capital Inicial') // Muestra este campo para todas las opciones excepto 'Capital Inicial'
              TextFormField(
                controller: _capitalController,
                decoration: const InputDecoration(
                  labelText: 'Capital',
                  hintText: 'Ingrese el capital inicial',
                  icon: Icon(Icons.monetization_on),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            if (_selectedCalculation !=
                'Tasa de Interés') // Muestra este campo para todas las opciones excepto 'Tasa de Interés'
              TextFormField(
                controller: _interestRateController,
                decoration: const InputDecoration(
                  labelText: 'Tasa de Interés (%)',
                  hintText: 'Ingrese la tasa de interés anual',
                  icon: Icon(Icons.percent),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            if (_selectedCalculation !=
                'Tiempo') // Muestra este campo para todas las opciones excepto 'Tiempo'
              TextFormField(
                controller: _periodController,
                decoration: const InputDecoration(
                  labelText: 'Periodo',
                  hintText: 'Ingrese el periodo',
                  icon: Icon(Icons.calendar_today),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            if (_selectedCalculation !=
                'Interés Compuesto') // Muestra este campo para todas las opciones excepto 'Interés Compuesto'
              TextFormField(
                controller: _finalAmountController,
                decoration: const InputDecoration(
                  labelText: 'Monto Compuesto',
                  hintText: 'Ingrese el monto compuesto deseado',
                  icon: Icon(Icons.monetization_on),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedTimeBase,
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTimeBase = newValue!;
                });
              },
              items: _timeBases.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedCalculation,
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCalculation = newValue!;
                });
              },
              items:
                  _calculations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF013542)),
              onPressed: _selectedCalculation == 'Interés Compuesto'
                  ? _calculateCompoundInterest
                  : _selectedCalculation == 'Capital Inicial'
                      ? _calculateInitialCapital
                      : _selectedCalculation == 'Tiempo'
                          ? _calculateTime
                          : _calculateInterestRate,
              child:
                  const Text('Calcular', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
