
import 'package:athikarai_emi/components/page/calc/input_widgets/input.dart';
import 'package:flutter/material.dart';

class PeriodInput extends StatelessWidget {
  final String tenureType;
  final bool switchValue;
  final Function(bool) onSwitchChanged;
  final TextEditingController monthsController;

  const PeriodInput({
    super.key,
    required this.tenureType,
    required this.switchValue,
    required this.onSwitchChanged,
    required this.monthsController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 5,
            child: InputField(label: tenureType, controller: monthsController)),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              Text(
                tenureType,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
