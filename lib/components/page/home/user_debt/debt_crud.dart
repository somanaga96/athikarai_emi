import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/PeriodInput.dart';
import '../../../utils/global.dart';

class DebtCrud extends ChangeNotifier {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  DateTime dateTime = DateTime.now();
  String name = "";
  final CollectionReference debt =
      FirebaseFirestore.instance.collection('debt');
  FirebaseFirestore db = FirebaseFirestore.instance;

  final List<String> _tenureTypes = [
    "கடன் ஆரம்பம்",
    "கடன் முடிவு",
  ];
  String _tenureType = "Loan Start";

  Future<List<String>> fetchDropdownItems() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      return querySnapshot.docs
          .map((doc) => doc.data()['name'] as String)
          .toList();
    } catch (e) {
      print('Error fetching dropdown items: $e');
      return [];
    }
  }

  Future<void> createOrUpdateDebt(
    BuildContext context, {
    String? existingDocId,
  }) async {
    String dropdownValue = 'தேர்ந்தெடுக்கவும்';
    List<String> dropdownItems = ['தேர்ந்தெடுக்கவும்'];
    bool isLoading = true;
    bool _switchValue = false;

    if (existingDocId != null) {
      DocumentSnapshot existingDoc = await debt.doc(existingDocId).get();
      amountController.text = existingDoc['amount'].toString();
      interestRateController.text = existingDoc['interestRate'].toString();
      dateTime = (existingDoc['date'] as Timestamp).toDate();
      _switchValue = existingDoc['status'];
      _tenureType = _switchValue ? _tenureTypes[0] : _tenureTypes[1];
      dropdownValue = existingDoc['name'];
    }

    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, StateSetter modalSetState) {
            if (isLoading) {
              fetchDropdownItems().then((items) {
                modalSetState(() {
                  dropdownItems = [...items];
                  isLoading = false;
                });
              });
            }

            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Add or Edit a Transaction',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButton<String>(
                          value: dropdownItems.contains(dropdownValue)
                              ? dropdownValue
                              : null,
                          hint: const Text("பெயர் தேர்ந்தெடுக்கவும்"),
                          icon: const Icon(Icons.search),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            if (value != null) {
                              modalSetState(() {
                                dropdownValue = value;
                              });
                            }
                          },
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text(
                                "பெயர் தேர்ந்தெடுக்கவும்",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            ...dropdownItems.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ),
                          ],
                        ),
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      labelText: 'விலை',
                      hintText: 'பொருளின் விலை',
                    ),
                  ),
                  TextField(
                    controller: interestRateController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      labelText: 'வட்டி',
                      hintText: 'வட்டி',
                    ),
                  ),
                  PeriodInput(
                    tenureType: _tenureType,
                    switchValue: _switchValue,
                    onSwitchChanged: (value) {
                      modalSetState(() {
                        _switchValue = value;
                        _tenureType = value ? _tenureTypes[1] : _tenureTypes[0];
                      });
                    },
                  ),
                  ElevatedButton(
                    child:
                        Text(DateFormat().addPattern('d/M/y').format(dateTime)),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now(),
                      );
                      if (newDate == null) return;
                      modalSetState(() => dateTime = newDate);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (amountController.text.trim().isEmpty ||
                              dropdownValue == 'தேர்ந்தெடுக்கவும்') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all fields!'),
                              ),
                            );
                            return;
                          }

                          final int? num = int.tryParse(amountController.text);
                          if (num == null || num < 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid amount!'),
                              ),
                            );
                            return;
                          }

                          final double? rate =
                              double.tryParse(interestRateController.text);
                          if (rate == null || rate < 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please enter a valid interest rate!'),
                              ),
                            );
                            return;
                          }

                          if (existingDocId == null) {
                            await debt.add({
                              'name': dropdownValue,
                              'amount': num,
                              'interestRate': rate,
                              'date': dateTime,
                              'status': _tenureType == _tenureTypes[0],
                            });
                          } else {
                            await debt.doc(existingDocId).update({
                              'name': dropdownValue,
                              'amount': num,
                              'interestRate': rate,
                              'date': dateTime,
                              'status': _tenureType == _tenureTypes[0],
                            });
                          }

                          amountController.text = '';
                          dateTime = DateTime.now();
                          Navigator.pop(ctx);

                          Provider.of<Global>(context, listen: false)
                              .fetchDebtList();
                          Provider.of<Global>(context, listen: false)
                              .transactionTotal();
                          Provider.of<Global>(context, listen: false)
                              .liveDebtCount();
                          Provider.of<Global>(context, listen: false)
                              .liveDebtSum();
                          Provider.of<Global>(context, listen: false)
                              .closedDebtCount();
                          Provider.of<Global>(context, listen: false)
                              .closedDebtSum();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> deleteDebt(String docId) async {
    try {
      await debt.doc(docId).delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
