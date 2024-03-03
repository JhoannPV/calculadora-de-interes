import 'package:flutter/material.dart';
import 'dart:math' as math;

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
        period = period / 365; // periodo de días a años
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
    double amount = principal * math.pow((1 + rate), period);

    // Mostrar el resultado
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text('Monto Compuesto: \$${amount.toStringAsFixed(1)}'),
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

  void _calculateInitialCapital() {
    double finalAmount =
        double.tryParse(_finalAmountController.text) ?? 0.0; // MC
    double rate = double.tryParse(_interestRateController.text) ?? 0.0; // i
    double period = double.tryParse(_periodController.text) ?? 0.0; // n

    // Formula
    double principal = finalAmount / math.pow((1 + rate / 100), period);

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

  void _calculateTime() {
    double mc = double.tryParse(_finalAmountController.text) ?? 0.0;
    double c = double.tryParse(_capitalController.text) ?? 0.0;
    double rate = double.tryParse(_interestRateController.text) ?? 0.0;

    double period = double.tryParse(_periodController.text) ?? 0.0;

    switch (_selectedTimeBase) {
      case 'Día':
        rate = rate / 100; //tasa anual a diaria
        period = period / 365; // periodo de días a años
        break;
      case 'Mes':
        rate = rate / 100; // tasa anual a mensual
        period = period / 12; // periodo de meses a años
        break;
      case 'Año':
        rate = rate / 100; // tasa de porcentaje a decimal
        break;
    }

    // fórmula para calcular el tiempo
    double logMC = math.log(mc);
    double logC = math.log(c);
    double logRate = math.log(1 + rate);

    double time = (logMC - logC) / logRate;

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

  void _calculateInterestRate() {
    double mc = double.tryParse(_finalAmountController.text) ?? 0.0;
    double c = double.tryParse(_capitalController.text) ?? 0.0;
    double period = double.tryParse(_periodController.text) ?? 0.0;

    //  fórmula para calcular la tasa de interés
    double rate = math.pow(mc / c, 1 / period) - 1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interés Compuesto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
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
              icon: const Icon(Icons.arrow_downward),
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
              icon: const Icon(Icons.arrow_downward),
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
              onPressed: _selectedCalculation == 'Interés Compuesto'
                  ? _calculateCompoundInterest
                  : _selectedCalculation == 'Capital Inicial'
                      ? _calculateInitialCapital
                      : _selectedCalculation == 'Tiempo'
                          ? _calculateTime
                          : _calculateInterestRate,
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
