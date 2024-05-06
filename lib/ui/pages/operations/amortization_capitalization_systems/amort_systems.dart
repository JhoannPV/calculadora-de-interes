import 'dart:math';

import 'package:flutter/material.dart';

class SistemaFrances extends StatefulWidget {
  final double deudaInicial;
  final double tasaInteres;
  final int cuotas;
  final String typeofinterest;

  const SistemaFrances(
      {super.key,
      required this.deudaInicial,
      required this.tasaInteres,
      required this.cuotas,
      required this.typeofinterest});

  @override
  State<SistemaFrances> createState() => _SistemaFrancesState();
}

class _SistemaFrancesState extends State<SistemaFrances> {
  double tasaInteresModified = 0.0;

  @override
  void initState() {
    super.initState();
    tasaInteresModified = widget.tasaInteres / 100;
    switch (widget.typeofinterest) {
      case 'Mensual':
        tasaInteresModified = tasaInteresModified / 12;
        break;
      case 'Bimestral':
        tasaInteresModified = tasaInteresModified / 6;
        break;
      case 'Trimestral':
        tasaInteresModified = tasaInteresModified / 4;
        break;
      case 'Cuatrimestral':
        tasaInteresModified = tasaInteresModified / 3;
        break;
      case 'Semestral':
        tasaInteresModified = tasaInteresModified / 2;
        break;
      case 'Anual':
        tasaInteresModified = tasaInteresModified / 1;
        break;
    }
  }

  double calcularCuota() {
    double numerador =
        tasaInteresModified * pow(1 + tasaInteresModified, widget.cuotas);
    double denominador = pow(1 + tasaInteresModified, widget.cuotas) - 1;
    return widget.deudaInicial * (numerador / denominador);
  }

  List<Map<String, dynamic>> calcularTablaAmortizacion() {
    double cuota = calcularCuota();
    double deudaRestante = widget.deudaInicial;
    List<Map<String, dynamic>> tablaAmortizacion = [];

    // Agregar fila inicial con la deuda inicial
    tablaAmortizacion.add({
      'cuota': 0,
      'cuotaValor': 0,
      'interes': 0,
      'amortizacion': 0,
      'deudaRestante': widget.deudaInicial,
    });

    for (int i = 1; i <= widget.cuotas; i++) {
      double interes = deudaRestante * tasaInteresModified;
      double amortizacion = cuota - interes;

      deudaRestante -= amortizacion;

      tablaAmortizacion.add({
        'cuota': i,
        'cuotaValor': cuota,
        'interes': interes,
        'amortizacion': amortizacion,
        'deudaRestante': deudaRestante,
      });
    }

    return tablaAmortizacion;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tablaAmortizacion = calcularTablaAmortizacion();
    return Center(
      child: DataTable(
        columns: const [
          DataColumn(
              label:
                  Text('Cuota', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Valor de la Cuota',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Interés',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Amortización',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Deuda Restante',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: tablaAmortizacion.map((fila) {
          return DataRow(cells: [
            DataCell(Text(fila['cuota'].toString())),
            DataCell(Text(fila['cuotaValor'].toStringAsFixed(2))),
            DataCell(Text(fila['interes'].toStringAsFixed(2))),
            DataCell(Text(fila['amortizacion'].toStringAsFixed(2))),
            DataCell(Text(fila['deudaRestante'].toStringAsFixed(2))),
          ]);
        }).toList(),
      ),
    );
  }
}

class SistemaAleman extends StatefulWidget {
  final double deudaInicial;
  final double tasaInteres;
  final int cuotas;
  final String typeofinterest;

  const SistemaAleman({
    super.key,
    required this.deudaInicial,
    required this.tasaInteres,
    required this.cuotas,
    required this.typeofinterest,
  });

  @override
  State<SistemaAleman> createState() => _SistemaAlemanState();
}

class _SistemaAlemanState extends State<SistemaAleman> {
  double tasaInteresModified = 0.0;

  @override
  void initState() {
    super.initState();
    tasaInteresModified = widget.tasaInteres / 100;
    switch (widget.typeofinterest) {
      case 'Mensual':
        tasaInteresModified = tasaInteresModified / 12;
        break;
      case 'Bimestral':
        tasaInteresModified = tasaInteresModified / 6;
        break;
      case 'Trimestral':
        tasaInteresModified = tasaInteresModified / 4;
        break;
      case 'Cuatrimestral':
        tasaInteresModified = tasaInteresModified / 3;
        break;
      case 'Semestral':
        tasaInteresModified = tasaInteresModified / 2;
        break;
      case 'Anual':
        tasaInteresModified = tasaInteresModified / 1;
        break;
    }
  }

  List<Map<String, dynamic>> calcularTablaAmortizacion() {
    double amortizacionConstante = widget.deudaInicial / widget.cuotas;
    double deudaRestante = widget.deudaInicial;
    List<Map<String, dynamic>> tablaAmortizacion = [];

    // Agregar fila inicial con la deuda inicial
    tablaAmortizacion.add({
      'cuota': 0,
      'cuotaValor': 0,
      'interes': 0,
      'amortizacion': 0,
      'deudaRestante': widget.deudaInicial,
    });

    for (int i = 1; i <= widget.cuotas; i++) {
      double interes = deudaRestante * tasaInteresModified;
      double cuota = interes + amortizacionConstante;

      deudaRestante -= amortizacionConstante;

      tablaAmortizacion.add({
        'cuota': i,
        'cuotaValor': cuota,
        'interes': interes,
        'amortizacion': amortizacionConstante,
        'deudaRestante': deudaRestante,
      });
    }

    return tablaAmortizacion;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tablaAmortizacion = calcularTablaAmortizacion();

    return Center(
      child: DataTable(
        columns: const [
          DataColumn(
              label:
                  Text('Cuota', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Valor de la Cuota',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Interés',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Amortización',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Deuda Restante',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: tablaAmortizacion.map((fila) {
          return DataRow(cells: [
            DataCell(Text(fila['cuota'].toString())),
            DataCell(Text(fila['cuotaValor'].toStringAsFixed(2))),
            DataCell(Text(fila['interes'].toStringAsFixed(2))),
            DataCell(Text(fila['amortizacion'].toStringAsFixed(2))),
            DataCell(Text(fila['deudaRestante'].toStringAsFixed(2))),
          ]);
        }).toList(),
      ),
    );
  }
}

class SistemaAmericano extends StatefulWidget {
  final double deudaInicial;
  final double tasaInteres;
  final int cuotas;
  final String typeofinterest;

  const SistemaAmericano({
    super.key,
    required this.deudaInicial,
    required this.tasaInteres,
    required this.cuotas,
    required this.typeofinterest,
  });

  @override
  State<SistemaAmericano> createState() => _SistemaAmericanoState();
}

class _SistemaAmericanoState extends State<SistemaAmericano> {
  double tasaInteresModified = 0.0;

  @override
  void initState() {
    super.initState();
    tasaInteresModified = widget.tasaInteres / 100;
    switch (widget.typeofinterest) {
      case 'Mensual':
        tasaInteresModified = tasaInteresModified / 12;
        break;
      case 'Bimestral':
        tasaInteresModified = tasaInteresModified / 6;
        break;
      case 'Trimestral':
        tasaInteresModified = tasaInteresModified / 4;
        break;
      case 'Cuatrimestral':
        tasaInteresModified = tasaInteresModified / 3;
        break;
      case 'Semestral':
        tasaInteresModified = tasaInteresModified / 2;
        break;
      case 'Anual':
        tasaInteresModified = tasaInteresModified / 1;
        break;
    }
  }

  List<Map<String, dynamic>> calcularTablaAmortizacion() {
    double interes = widget.deudaInicial * tasaInteresModified;
    double deudaRestante = widget.deudaInicial;
    List<Map<String, dynamic>> tablaAmortizacion = [];

    // Agregar fila inicial con la deuda inicial
    tablaAmortizacion.add({
      'cuota': 0,
      'cuotaValor': 0,
      'interes': 0,
      'amortizacion': 0,
      'deudaRestante': widget.deudaInicial,
    });

    for (int i = 1; i <= widget.cuotas; i++) {
      double amortizacion = (i == widget.cuotas) ? widget.deudaInicial : 0;
      double cuota = interes + amortizacion;

      deudaRestante -= amortizacion;

      tablaAmortizacion.add({
        'cuota': i,
        'cuotaValor': cuota,
        'interes': interes,
        'amortizacion': amortizacion,
        'deudaRestante': deudaRestante,
      });
    }

    return tablaAmortizacion;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tablaAmortizacion = calcularTablaAmortizacion();

    return Center(
      child: DataTable(
        columns: const [
          DataColumn(
              label:
                  Text('Cuota', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Valor de la Cuota',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Interés',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Amortización',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Deuda Restante',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: tablaAmortizacion.map((fila) {
          return DataRow(cells: [
            DataCell(Text(fila['cuota'].toString())),
            DataCell(Text(fila['cuotaValor'].toStringAsFixed(2))),
            DataCell(Text(fila['interes'].toStringAsFixed(2))),
            DataCell(Text(fila['amortizacion'].toStringAsFixed(2))),
            DataCell(Text(fila['deudaRestante'].toStringAsFixed(2))),
          ]);
        }).toList(),
      ),
    );
  }
}
