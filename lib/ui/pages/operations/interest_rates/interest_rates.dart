import 'package:flutter/material.dart';

class InterestRates extends StatefulWidget {
  const InterestRates({super.key});

  @override
  State<InterestRates> createState() => _InterestRatesState();
}

class _InterestRatesState extends State<InterestRates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasas de Interes'),
      ),
      body: Container(),
    );
  }
}
