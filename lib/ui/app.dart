import 'package:calculadora_de_interes/ui/pages/home/home.dart';
import 'package:calculadora_de_interes/ui/pages/operations/amortization_capitalization_systems/amort_cap_systems.dart';
import 'package:calculadora_de_interes/ui/pages/operations/annuities/annuities.dart';
import 'package:calculadora_de_interes/ui/pages/operations/compound_interest/compound_interest.dart';
import 'package:calculadora_de_interes/ui/pages/operations/gradients/gradients.dart';
import 'package:calculadora_de_interes/ui/pages/operations/returne_interest/interest_returne.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest/simple_interest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: 'Calculadora de Interes',
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Home(),
        "/simple_interest": (context) => const SimpleInterest(),
        "/compound_interest": (context) => const CompoundInterest(),
        "/annuities": (context) => const Annuities(),
        "/interest_return": (context) => const InterestReturn(),
        "/gradients": (context) => const Gradients(),
        "/amort_cap_systems": (context) => const AmortCapSystems(),
      },
    );
  }
}
