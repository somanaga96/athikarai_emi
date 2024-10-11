import 'package:athikarai_emi/components/page/home/debts/DebtTool.dart';
import 'package:athikarai_emi/components/page/home/debts/debt_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../page/home/user_debt/UserTool.dart';

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

// Debt

  List<Debt> _debtLiveTransactionList = [];
  List<Debt> _debtClosedTransactionList = [];

  void fetchDebtList() async {
    _debtLiveTransactionList.clear();
    _debtClosedTransactionList.clear();
    try {
      DebtTool tool = DebtTool();
      List<Debt> liveTransactions = await tool.fetchLiveDebtTransaction();
      List<Debt> closedTransactions = await tool.fetchClosedDebtTransaction();
      _debtLiveTransactionList.addAll(liveTransactions);
      _debtClosedTransactionList.addAll(closedTransactions);
      notifyListeners(); // Notify listeners after adding transactions
    } catch (error) {
      print('Error fetching transactions: $error');
    }
  }

  List<Debt> get debtLiveTransactionList => _debtLiveTransactionList;

  List<Debt> get debtClosedTransactionList => _debtClosedTransactionList;

//User Debt

  List<Debt> _userDebtLiveTransactionList = [];
  List<Debt> _userDebtClosedTransactionList = [];

  void fetchUserDebtList(String name) async {
    _userDebtLiveTransactionList.clear();
    _userDebtClosedTransactionList.clear();
    try {
      UserTool tool = UserTool();
      List<Debt> liveTransactions =
          await tool.fetchUserDebtLiveTransaction(name);
      List<Debt> closedTransactions =
          await tool.fetchUserDebtClosedTransaction(name);
      _userDebtLiveTransactionList.addAll(liveTransactions);
      _userDebtClosedTransactionList.addAll(closedTransactions);
      notifyListeners(); // Notify listeners after adding transactions
    } catch (error) {
      print('Error fetching transactions: $error');
    }
  }

  List<Debt> get userDebtLiveTransactionList => _userDebtLiveTransactionList;

  List<Debt> get userDebtClosedTransactionList =>
      _userDebtClosedTransactionList;

  //debt overall
  int _debtSum = 0;
  int _debtCount = 0;

  void debt() async {
    _debtSum = 0;
    _debtCount = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('debt').get();
    for (var doc in querySnapshot.docs) {
      _debtSum += int.parse(doc.data()['amount'].toString());
      _debtCount = _debtCount + 1;
    }
    notifyListeners();
  }

  int get debtCount => _debtCount;

  int get debtSum => _debtSum;

  //User
  int _userDebtSum = 0;
  int _userDebtCount = 0;

  int get userDebtSum => _userDebtSum;

  int get userDebtCount => _userDebtCount;
}

// List<Debt> get userLiveDebtList => _userLiveDebtList;

// void fetchDebtLiveTransactionList() async {
//   _debtLiveTransactionList.clear();
//   _debtClosedTransactionList.clear();
//   try {
//     DebtTool tools = DebtTool();
//     List<Debt> transactions = await tools.fetchLiveDebtTransaction();
//     // print('Fetched Transactions: $transactions');
//     _debtLiveTransactionList.addAll(transactions);
//     notifyListeners(); // Notify listeners after adding transactions
//   } catch (error) {
//     print('Error fetching transactions: $error');
//   }
// }
