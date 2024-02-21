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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de Interes'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
