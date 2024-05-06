import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF013542),
            ),
            child: Text(
              'Calculadora de Interes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Interes Simple'),
            onTap: () {
              Navigator.pushNamed(context, '/simple_interest');
            },
          ),
          ListTile(
            title: const Text('Interes Compuesto'),
            onTap: () {
              Navigator.pushNamed(context, '/compound_interest');
            },
          ),
          ListTile(
            title: const Text('Anualidades'),
            onTap: () {
              Navigator.pushNamed(context, '/annuities');
            },
          ),
          ListTile(
            title: const Text('Retorno de Interes'),
            onTap: () {
              Navigator.pushNamed(context, '/taza_interesr');
            },
          ),
        ],
      ),
    );
  }
}
