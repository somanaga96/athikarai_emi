import 'package:athikarai_emi/components/page/home/debts/debt_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../page/home/debts/DebtTool.dart';

class Global extends ChangeNotifier {
  //Theme data
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;
  final ThemeData _lightTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);

  final ThemeData _darkTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // Toggle the theme mode
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  //Title
  final String _title = "Athikarai EMI";

  String getTitle() {
    return _title;
  }

  //Transactions
  int _sum = 0;
  int _count = 0;

  void transactionTotal() async {
    _sum = 0;
    _count = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('amount').get();
    for (var doc in querySnapshot.docs) {
      _sum += int.parse(doc.data()['amount'].toString());
      _count = _count + 1;
    }
    notifyListeners();
  }

  int get sum => _sum;

  int get count => _count;

//Debt
  int _debtSum = 0;
  int _debtCount = 0;

  List<Debt> _debtLiveTransactionList = [];

  void debt() async {
    _debtSum = 0;
    _debtCount = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('debt')
            // .where('status', isEqualTo: true)
            // .where('status', isEqualTo: true)
            .get();
    for (var doc in querySnapshot.docs) {
      _debtSum += int.parse(doc.data()['amount'].toString());
      _debtCount = _debtCount + 1;
    }
    notifyListeners();
  }

  int get debtCount => _debtCount;

  int get debtSum => _debtSum;

  void fetchDebtLiveTransactionList() async {
    _debtLiveTransactionList.clear();
    try {
      DebtTool tools = DebtTool();
      List<Debt> transactions = await tools.fetchLiveDebtTransaction();
      print('Fetched Transactions: $transactions');
      _debtLiveTransactionList.addAll(transactions);
      notifyListeners(); // Notify listeners after adding transactions
    } catch (error) {
      print('Error fetching transactions: $error');
    }
  }

  List<Debt> get debtLiveTransactionList => _debtLiveTransactionList;
}
