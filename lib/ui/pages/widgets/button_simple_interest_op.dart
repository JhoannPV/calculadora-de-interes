import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonSimpleInterestOp extends StatelessWidget {
  const ButtonSimpleInterestOp({
    super.key,
    required this.route,
    required this.title,
  });
  final String route;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Material(
        color: const Color.fromARGB(255, 0, 119, 255),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          onTap: () => Get.toNamed(route),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.13,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
