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
  TableRow buildTableRow() {
    return TableRow(
      children: [
        Text(date, style: const TextStyle(fontSize: 18.0)),
        Text(amount.toStringAsFixed(1), style: const TextStyle(fontSize: 20.0)),
        Text(interest.toStringAsFixed(2), style: const TextStyle(fontSize: 20.0)),
        Text(emi.toStringAsFixed(1), style: const TextStyle(fontSize: 20.0)),
      ],
    );
  }
}
