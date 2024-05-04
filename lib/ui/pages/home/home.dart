import 'package:calculadora_de_interes/ui/pages/widgets/button_operation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 170, 201, 209),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: double.infinity,
              height: 120,
              alignment: Alignment.center,
              color: const Color(0xFF013542),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'Interest Calc',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonOperation(
                route: "/simple_interest",
                title: "Interes Simple",
                icon: Icons.calculate,
              ),
              ButtonOperation(
                route: "/compound_interest",
                title: "Interes Compuesto",
                icon: Icons.calculate_outlined,
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonOperation(
                route: "/annuities",
                title: "Anualidades",
                icon: Icons.calculate,
              ),
              ButtonOperation(
                route: "/interest_return",
                title: "Tasa de Interes de Retorno",
                icon: Icons.trending_up,
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonOperation(
                route: "/gradients",
                title: "Gradientes",
                icon: Icons.gradient_rounded,
              ),
            ],
          )
        ],
      )),
    );
  }
}
