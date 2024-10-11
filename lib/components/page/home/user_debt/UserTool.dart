import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../debts/debt_class.dart';

class UserTool extends ChangeNotifier {
  Future<List<Debt>> fetchUserDebtLiveTransaction(String name) async {
    List<Debt> objectList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('debt')
              .where('name', isEqualTo: name)
              .where('status', isEqualTo: true)
              .get();

      // Check if there are documents in the querySnapshot
      print('Number of documents fetched: ${querySnapshot.docs.length}');

      for (var doc in querySnapshot.docs) {
        DateTime date = (doc.data()['date'] as Timestamp).toDate();

        // Create the Debt object
        Debt yourObject = Debt(
            id: doc.id,
            amount: doc.data()['amount'],
            date: date,
            name: doc.data()['name'],
            status: doc.data()['status']);
        objectList.add(yourObject);
        print('Debt added: ${yourObject.name}, Amount: ${yourObject.amount}');
      }

      // Notify listeners to update the UI
      notifyListeners();

      // Print the entire list
      print('Final debt list: $objectList');
      return objectList;
    } catch (e) {
      // Print any errors for debugging
      print('Error fetching debt transactions: $e');
      return [];
    }
  }

  Future<List<Debt>> fetchUserDebtClosedTransaction(String name) async {
    List<Debt> objectList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('debt')
              .where('name', isEqualTo: name)
              .where('status', isEqualTo: false)
              .get();

      // Check if there are documents in the querySnapshot
      print('Number of documents fetched: ${querySnapshot.docs.length}');

      for (var doc in querySnapshot.docs) {
        DateTime date = (doc.data()['date'] as Timestamp).toDate();

        // Create the Debt object
        Debt yourObject = Debt(
            id: doc.id,
            amount: doc.data()['amount'],
            date: date,
            name: doc.data()['name'],
            status: doc.data()['status']);
        objectList.add(yourObject);
        print('Debt added: ${yourObject.name}, Amount: ${yourObject.amount}');
      }

      // Notify listeners to update the UI
      notifyListeners();

      // Print the entire list
      print('Final debt list: $objectList');
      return objectList;
    } catch (e) {
      // Print any errors for debugging
      print('Error fetching debt transactions: $e');
      return [];
    }
  }
}
