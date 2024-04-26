import 'package:flutter/material.dart';

class TazaInteres extends StatelessWidget {
  const TazaInteres({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retorno de interes'),
        backgroundColor: const Color(0xFF013542),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const ExpansionTile(
              title: Text('¿Qué es el Retorno de interes?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                    'El retonor de interes es una medida que indica cuánto dinero se gana o se pierde en una inversión en relación con la cantidad de dinero invertido. Se expresa generalmente como un porcentaje y puede calcularse para diferentes periodos de tiempo, como anual, mensual o diario.',
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
            )
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
}
