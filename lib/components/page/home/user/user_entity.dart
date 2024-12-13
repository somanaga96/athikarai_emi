import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id; // Firebase document ID field
  int amount;
  String name;
  String villageName;

  User(
      {required this.id,
      required this.amount,
      required this.name,
      required this.villageName}); // Updated constructor

  factory User.fromMap(String id, Map<String, dynamic> map) {
    // Updated factory constructor
    return User(
        id: id,
        // Assigning Firebase document ID
        amount: map['amount'],
        name: map['name'],
        villageName: map['village name']);
  }
}
