import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';
import '../user_debt/user_crud.dart';
import '../user_debt/user_loans.dart';

class ClosedLoans extends StatefulWidget {
  const ClosedLoans({super.key});

  @override
  State<ClosedLoans> createState() => _ClosedLoansState();
}

class _ClosedLoansState extends State<ClosedLoans> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserCrud userCrud = UserCrud();
    return Consumer<Global>(
      builder: (context, global, child) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (global.debtClosedTransactionList.isEmpty) {
          return const Center(child: Text('No closed loans are available.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: global.debtClosedTransactionList.length,
          itemBuilder: (BuildContext context, int index) {
            final DateFormat formatter = DateFormat('d-MMM-yy');
            String dateAndMonth =
                formatter.format(global.debtClosedTransactionList[index].date);

            return Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ListTile(
                title: Text(
                  '${global.debtClosedTransactionList[index].name} : ${global.debtClosedTransactionList[index].amount}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  dateAndMonth,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Call the createOrUpdateDebt function with docId
                        userCrud.createOrUpdateDebt(
                          context,
                          existingDocId:
                              global.debtClosedTransactionList[index].id,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Call the deleteDebt function with docId
                        await userCrud.deleteDebt(
                          global.debtClosedTransactionList[index].id,
                        );
                        Provider.of<Global>(context, listen: false)
                            .fetchDebtList();
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
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to the DebtDetailsPage when a row is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLoans(
                          name: global.debtClosedTransactionList[index].name),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
