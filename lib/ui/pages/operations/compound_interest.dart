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
        rate = rate / 365; // Asumir tasa anual, ajustar a diaria
        period = period / 12; // Convertir periodo de días a años
        break;
      case 'Mes':
        rate = rate / 12; // Ajustar tasa anual a mensual
        period = period / 12; // Convertir periodo de meses a años
        break;
      case 'Año':
        rate = rate;
        period = period / 12; // Convertir tasa de porcentaje a decimal
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
          content: Text('Monto Compuesto: \$${amount.toStringAsFixed(2)}'),
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
              'Capital Inicial Requerido: \$${principal.toStringAsFixed(2)}'),
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
        rate = rate / 365; // Ajustar tasa anual a diaria
        period = period / 365; // Convertir periodo de días a años
        break;
      case 'Mes':
        rate = rate / 12; // Ajustar tasa anual a mensual
        period = period / 12; // Convertir periodo de meses a años
        break;
      case 'Año':
        rate = rate / 100; // Convertir tasa de porcentaje a decimal
        break;
    }

    // Aplicar la fórmula para calcular el tiempo
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

    // Aplicar la fórmula para calcular la tasa de interés
    double rate = math.pow(mc / c, 1 / period) - 1;

    // Mostrar el resultado
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text('Tasa de Interés: ${(rate * 100).toStringAsFixed(2)}%'),
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
            TextFormField(
              controller: _finalAmountController,
              decoration: const InputDecoration(
                labelText: 'Monto Compuesto',
                hintText: 'Ingrese el monto compuesto',
                icon: Icon(Icons.monetization_on),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.grey),
                const SizedBox(width: 15),
                Text('Base de Tiempo: $_selectedTimeBase'),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    setState(() {
                      _selectedTimeBase = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return _timeBases
                        .map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList();
                  },
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.calculate, color: Colors.grey),
                const SizedBox(width: 15),
                Text('Tipo de cálculo: $_selectedCalculation'),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    setState(() {
                      _selectedCalculation = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return _calculations
                        .map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList();
                  },
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ),
              ],
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
