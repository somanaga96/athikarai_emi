import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../debts/debt_class.dart';

class UserTool extends ChangeNotifier {
  //open debt user sum
  double userLiveDebtSum = 0;

  Future<double> userLiveDebtSums(String name) async {
    userLiveDebtSum = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: true)
        .where('name', isEqualTo: name)
        .get();
    for (var doc in querySnapshot.docs) {
      userLiveDebtSum += int.parse(doc.data()['amount'].toString());
    }
    notifyListeners();
    return userLiveDebtSum;
  }

  //close debt user sum
  double userClosedDebtSum = 0;

  Future<double> userClosedDebtSums(String name) async {
    userClosedDebtSum = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: true)
        .where('name', isEqualTo: name)
        .get();
    for (var doc in querySnapshot.docs) {
      userClosedDebtSum += int.parse(doc.data()['amount'].toString());
    }
    notifyListeners();
    return userClosedDebtSum;
  }

  //open debt user count
  int userLiveDebtCount = 0;

  Future<int> userLiveDebtCounts(String name) async {
    userLiveDebtCount = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: true)
        .where('name', isEqualTo: name)
        .get();
    notifyListeners();
    return querySnapshot.size;
  }

  //close debt user count
  int userClosedDebtCount = 0;

  Future<int> userClosedDebtCounts(String name) async {
    userClosedDebtCount = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: true)
        .where('name', isEqualTo: name)
        .get();
    notifyListeners();
    return querySnapshot.size;
  }

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
