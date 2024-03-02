import 'package:calculadora_de_interes/ui/pages/home/home.dart';
import 'package:calculadora_de_interes/ui/pages/operations/annuities/annuities.dart';
import 'package:calculadora_de_interes/ui/pages/operations/compound_interest/compound_interest.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest/simple_interest.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest/views/amount_principal_interest_s.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest/views/interest_s.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest/views/principal_interest_s.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest/views/rate_interest_s.dart';
import 'package:calculadora_de_interes/ui/pages/operations/simple_interest/views/time_interest_s.dart';
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
        "/annuities": (context) => const Annuities(),
        "/interest_s": (context) => const InterestS(),
        "/time_interest_s": (context) => const TimeInterestS(),
        "/principal_interest_s": (context) => const PrincipalInterestS(),
        "/rate_interest_s": (context) => const RateInterestS(),
        "/amount_principal_interest_s": (context) =>
            const AmountPrincipalInterestS(),
      },
    );
  }
}
