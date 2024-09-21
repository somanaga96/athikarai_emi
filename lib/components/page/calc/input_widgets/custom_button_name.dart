import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      onPressed: onPressed,
      child: Text(buttonName),
    );
  }
}
