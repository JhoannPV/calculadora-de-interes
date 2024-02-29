import 'package:calculadora_de_interes/ui/pages/home/home.dart';
import 'package:calculadora_de_interes/ui/pages/operations/annuities.dart';
import 'package:calculadora_de_interes/ui/pages/operations/compound_interest.dart';
import 'package:calculadora_de_interes/ui/pages/operations/interest_rates.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest.dart';
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
        "/interest_rates": (context) => const InterestRates(),
        "/annuities": (context) => const Annuities(),
      },
    );
  }
}
