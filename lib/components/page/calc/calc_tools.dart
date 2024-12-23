import 'package:flutter/material.dart';

import '../details_screen.dart';

class CalculatorTool {
  void calculate(
      BuildContext context,
      TextEditingController amount,
      TextEditingController months,
      TextEditingController rate,
      String tenureType,
      Function(Map<String, dynamic>) callback) {
    if (amount.text.isEmpty || months.text.isEmpty || rate.text.isEmpty) {
      // Show error dialog if any of the fields are empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Please fill all fields (Amount, Months, and Interest) to calculate the EMI.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      double period = tenureType == "Years"
          ? double.parse(months.text) * 12
          : double.parse(months.text);
      callback({"canShow": true, "period": period});
    }
  }

  void reset(Function resetCallback) {
    resetCallback();
  }

  void showDetails(
      BuildContext context,
      TextEditingController amount,
      TextEditingController months,
      TextEditingController rate,
      String tenureType,
      bool canShow,
      DateTime dateTime,
      double period) {
    if (canShow) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailScreen(amount.text, rate.text, period, canShow, dateTime),
        ),
      );
    }
  }
}
