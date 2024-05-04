import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            title: const Text('Pagina Principal'),
            onTap: () {
              Get.offNamed('/home');
            },
          ),
          ListTile(
            title: const Text('Interes Simple'),
            onTap: () {
              Get.offNamed('/simple_interest');
            },
          ),
          ListTile(
            title: const Text('Interes Compuesto'),
            onTap: () {
              Get.offNamed('/compound_interest');
            },
          ),
          ListTile(
            title: const Text('Anualidades'),
            onTap: () {
              Get.offNamed('/annuities');
            },
          ),
          ListTile(
            title: const Text('Retorno de Interes'),
            onTap: () {
              Get.offNamed('/interest_return');
            },
          ),
          ListTile(
            title: const Text('Gradientes'),
            onTap: () {
              Get.offNamed('/gradients');
            },
          ),
        ],
      ),
    );
  }
}
