import 'package:athikarai_emi/components/page/calc/input_widgets/input.dart';
import 'package:athikarai_emi/components/page/home/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/global.dart';
import 'calc_tools.dart';
import 'emi_result.dart';
import 'input_widgets/custom_button_name.dart';
import 'input_widgets/period_input.dart';

class CalcHome extends StatefulWidget {
  const CalcHome({super.key});

  @override
  State<CalcHome> createState() => _CalcHomeState();
}

class _CalcHomeState extends State<CalcHome> {
  Global global = Global();
  final List _tenureTypes = ["Months", "Years"];
  String _tenureType = "Months";
  final TextEditingController amount = TextEditingController();
  final TextEditingController months = TextEditingController(text: "10");
  final TextEditingController rate = TextEditingController(text: "12");
  bool _switchValue = false;

  bool canShow = false;
  double period = 0;
  DateTime dateTime = DateTime.now();
  final CalculatorTool calculatorTool = CalculatorTool();

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
                          onPressed: () => calculatorTool.calculate(
                              context, amount, months, rate, _tenureType,
                              (value) {
                            setState(() {
                              canShow = value['canShow'];
                              period = value['period'];
                            });
                          }),
                        ),
                        CustomButton(
                          buttonName: "Reset",
                          onPressed: () => calculatorTool.reset(() {
                            setState(() {
                              rate.text = "12";
                              months.text = "10";
                              amount.clear();
                              canShow = false;
                            });
                          }),
                        ),
                        CustomButton(
                          buttonName: "Details",
                          onPressed: () => calculatorTool.showDetails(
                              context,
                              amount,
                              months,
                              rate,
                              _tenureType,
                              canShow,
                              dateTime,
                              period),
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
}
