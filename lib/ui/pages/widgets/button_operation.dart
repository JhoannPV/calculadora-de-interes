import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonOperation extends StatelessWidget {
  const ButtonOperation({
    super.key,
    required this.route,
    required this.title,
    required this.icon,
  });
  final String route;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      child: InkWell(
        onTap: () => Get.toNamed(route),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: SizedBox(
          width: 155,
          height: 155,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: Colors.blue),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 102, 168)),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
