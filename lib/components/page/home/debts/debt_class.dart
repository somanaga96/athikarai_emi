import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Debt {
  String id; // Firebase document ID field
  int amount;
  DateTime date;
  String name;
  bool status;

  Debt(
      {required this.id,
      required this.amount,
      required this.date,
      required this.name,
      required this.status}); // Updated constructor

  factory Debt.fromMap(String id, Map<String, dynamic> map) {
    // Updated factory constructor
    return Debt(
        id: id,
        // Assigning Firebase document ID
        amount: map['amount'],
        date: (map['date'] as Timestamp).toDate(),
        name: map['name'],
        status: map['status']);
  }
}
