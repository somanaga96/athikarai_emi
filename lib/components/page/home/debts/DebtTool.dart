import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'debt_entity.dart';

class DebtTool extends ChangeNotifier {
  //live debt count
  int liveDebtCount = 0;

  Future<int> liveDebtCounts() async {
    liveDebtCount = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: true)
        .get();
    notifyListeners();
    return querySnapshot.size;
  }

//closed debt count
  int closedDebtCount = 0;

  Future<int> closedDebtCounts() async {
    closedDebtCount = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: false)
        .get();
    notifyListeners();
    return querySnapshot.size;
  }

  //live debt sum
  double liveDebtSum = 0;

  Future<double> liveDebtSums() async {
    liveDebtSum = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: true)
        .get();
    for (var doc in querySnapshot.docs) {
      liveDebtSum += int.parse(doc.data()['amount'].toString());
    }
    notifyListeners();
    return liveDebtSum;
  }

  //closed debt sum
  double closedDebtSum = 0;

  Future<double> closedDebtSums() async {
    closedDebtSum = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('debt')
        .where('status', isEqualTo: false)
        .get();
    for (var doc in querySnapshot.docs) {
      closedDebtSum += int.parse(doc.data()['amount'].toString());
    }
    notifyListeners();
    return closedDebtSum;
  }

  Future<List<Debt>> fetchLiveDebtTransaction() async {
    List<Debt> objectList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('debt')
              .where("status", isEqualTo: true)
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

  Future<List<Debt>> fetchClosedDebtTransaction() async {
    List<Debt> objectList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('debt')
              .where("status", isEqualTo: false)
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
