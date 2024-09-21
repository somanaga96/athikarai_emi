import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const InputField({Key? key, required this.label, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.clear),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
