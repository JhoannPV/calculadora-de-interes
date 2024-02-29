import 'package:flutter/material.dart';

class Annuities extends StatefulWidget {
  const Annuities({super.key});

  @override
  State<Annuities> createState() => _AnnuitiesState();
}

class _AnnuitiesState extends State<Annuities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anualidades'),
      ),
      body: Container(),
    );
  }
}
