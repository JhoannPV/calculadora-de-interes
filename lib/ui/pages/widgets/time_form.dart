import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  const Time({
    super.key,
    required this.title,
    required this.yearController,
    required this.monthController,
    required this.dayController,
  });
  final String title;
  final TextEditingController yearController;
  final TextEditingController monthController;
  final TextEditingController dayController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          controller: yearController,
          decoration: const InputDecoration(
            labelText: 'Años',
            icon: Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: monthController,
          decoration: const InputDecoration(
            labelText: 'Meses',
            icon: Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: dayController,
          decoration: const InputDecoration(
            labelText: 'Días',
            icon: Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
