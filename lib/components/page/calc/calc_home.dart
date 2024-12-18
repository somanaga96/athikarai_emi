import 'package:athikarai_emi/components/page/details_screen.dart';
import 'package:athikarai_emi/components/page/calc/input_widgets/input.dart';
import 'package:athikarai_emi/components/page/home/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/global.dart';
import 'emi_result.dart';
import 'input_widgets/custom_button_name.dart';
import 'input_widgets/period_input.dart';

class CalcHome extends StatefulWidget {
  const CalcHome({super.key});

  @override
  State<CalcHome> createState() => _CalcHomeState();
}

class _CalcHomeState extends State<CalcHome> {
  Global global=Global();
  final List _tenureTypes = ["Months", "Years"];
  String _tenureType = "Months";
  final TextEditingController amount = TextEditingController();
  final TextEditingController months = TextEditingController(text: "10");
  final TextEditingController rate = TextEditingController(text: "12");
  bool _switchValue = false;

  bool canShow = false;
  double period = 0;
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
        builder: (context, global, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(global.getTitle()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
            body: GestureDetector(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputField(label: "Amount", controller: amount),
                    PeriodInput(
                      tenureType: _tenureType,
                      switchValue: _switchValue,
                      onSwitchChanged: (value) {
                        setState(() {
                          _tenureType =
                              value ? _tenureTypes[1] : _tenureTypes[0];
                          _switchValue = value;
                        });
                      },
                      monthsController: months,
                    ),
                    InputField(label: "Interest", controller: rate),
                    ElevatedButton(
                        child: Text(
                            DateFormat().addPattern('d/M/y').format(dateTime)),
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime.now());
                          if (newDate == null) return;
                          setState(() => dateTime = newDate);
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          buttonName: "Calculate",
                          onPressed: _calculate,
                        ),
                        CustomButton(
                          buttonName: "Reset",
                          onPressed: _reset,
                        ),
                        if (canShow)
                          CustomButton(
                            buttonName: "Details",
                            onPressed: _showDetails,
                          ),
                      ],
                    ),
                    if (canShow)
                      EmiResult(
                        amount: amount.text,
                        interest: rate.text,
                        canShow: canShow,
                        period: period,
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            )));
  }

  void _calculate() {
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
      setState(() {
        canShow = true;
        period = _tenureType == "Years"
            ? double.parse(months.text) * 12
            : double.parse(months.text);
      });
    }
  }

  void _reset() {
    setState(() {
      rate.text = "12";
      months.text = "10";
      amount.clear();
      canShow = false;
    });
  }

  void _showDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(amount.text, rate.text, period, canShow, dateTime),
      ),
    );
  }
}
