import 'package:flutter/material.dart';

class TableRowValueWidget {
  final int index;
  final String date;
  final double amount;
  final double interest;
  final double emi;

  TableRowValueWidget({
    required this.index,
    required this.date,
    required this.amount,
    required this.interest,
    required this.emi,
  });

  // Returns a TableRow
  TableRow buildTableRow(BuildContext context) {
    // Get the width of the screen
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    // Define padding as a percentage of screen width
    double paddingValue = screenWidth * 0.02; // 2% of the screen width

    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(paddingValue),
          child: Text(date, style: const TextStyle(fontSize: 18.0)),
        ),
        Padding(
          padding: EdgeInsets.all(paddingValue),
          child: Text(amount.toStringAsFixed(0),
              style: const TextStyle(fontSize: 20.0)),
        ),
        Padding(
          padding: EdgeInsets.all(paddingValue),
          child: Text(interest.toStringAsFixed(0),
              style: const TextStyle(fontSize: 20.0)),
        ),
        Padding(
          padding: EdgeInsets.all(paddingValue),
          child: Text(
              emi.toStringAsFixed(0), style: const TextStyle(fontSize: 20.0)),
        ),
      ],
    );
  }

}