import 'package:athikarai_emi/components/page/home/debts/DebtTool.dart';
import 'package:athikarai_emi/components/page/home/debts/debt_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../page/home/user_debt/DebtTool.dart';

class Global extends ChangeNotifier {
  //Theme data
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;
  final ThemeData _lightTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);

  final ThemeData _darkTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
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

  int debtLiveCount = 0;
  double debtLiveSum = 0.0;
  DebtTool debtTool = DebtTool();

  Future<void> liveDebtCount() async {
    debtLiveCount = await debtTool.liveDebtCounts();
    notifyListeners(); // Notify listeners that the debt count is updated
  }

  Future<void> liveDebtSum() async {
    debtLiveSum = await debtTool.liveDebtSums();
    notifyListeners(); // Notify listeners that the debt count is updated
  }

  int debtClosedCount = 0;
  double debtClosedSum = 0.0;

  Future<void> closedDebtCount() async {
    debtClosedCount = await debtTool.closedDebtCounts();
    notifyListeners(); // Notify listeners that the debt count is updated
  }

  Future<void> closedDebtSum() async {
    debtClosedSum = await debtTool.closedDebtSums();
    notifyListeners(); // Notify listeners that the debt count is updated
  }

  //User

  UserTool userTool = UserTool();
  int userLiveDebtCount = 0;
  int userClosedDebtCount = 0;
  double userLiveDebtSum = 0.0;
  double userClosedDebtSum = 0.0;

  Future<void> userLiveDebtCounts(String name) async {
    userLiveDebtCount = await userTool.userLiveDebtCounts(name);
    notifyListeners(); // Notify listeners that the debt count is updated
  }

  Future<void> userLiveDebtSums(String name) async {
    userLiveDebtSum = await userTool.userLiveDebtSums(name);
    notifyListeners(); // Notify listeners that the debt count is updated
  }

  Future<void> userClosedDebtCounts(String name) async {
    userClosedDebtCount = await userTool.userClosedDebtCounts(name);
    notifyListeners(); // Notify listeners that the debt count is updated
  }

  Future<void> userClosedDebtSums(String name) async {
    userClosedDebtSum = await userTool.userClosedDebtSums(name);
    notifyListeners(); // Notify listeners that the debt count is updated
  }
}
