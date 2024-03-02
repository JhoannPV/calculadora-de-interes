import 'package:calculadora_de_interes/ui/pages/widgets/button_simple_interest_op.dart';
import 'package:flutter/material.dart';

class SimpleInterest extends StatefulWidget {
  const SimpleInterest({super.key});

  @override
  State<SimpleInterest> createState() => _SimpleInterestState();
}

class _SimpleInterestState extends State<SimpleInterest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Interes Simple'),
        ),
        body: const SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Operaciones de Interes Simple',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 102, 168)),
                  ),
                ),
                ButtonSimpleInterestOp(
                  route: "/interest_s",
                  title: "Interes Simple y Monto",
                ),
                ButtonSimpleInterestOp(
                  route: "/time_interest_s",
                  title: "Tiempo",
                ),
                ButtonSimpleInterestOp(
                  route: "/principal_interest_s",
                  title: "Capital Inicial",
                ),
                ButtonSimpleInterestOp(
                  route: "/rate_interest_s",
                  title: "Tasa de Interes",
                ),
                ButtonSimpleInterestOp(
                  route: "/amount_principal_interest_s",
                  title: "Monto - Capital = Interes",
                ),
              ],
            ),
          ],
        )));
  }
}
