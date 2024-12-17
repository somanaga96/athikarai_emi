import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';
import '../user_debt/debt_crud.dart';
import '../user_debt/user_loans.dart';

class OpenLoans extends StatefulWidget {
  const OpenLoans({super.key});

  @override
  State<OpenLoans> createState() => _OpenLoansState();
}

class _OpenLoansState extends State<OpenLoans> {
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
    DebtCrud debtCrud = DebtCrud();
    Global globals = Global();

    return Consumer<Global>(
      builder: (context, global, child) {
        print('Current user set in open page: ${global.getUser()}');
        String name = global.getUser();
        print('Current user set in open page name: $name');
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // After the data is fetched, check if the list is empty
        if (global.debtLiveTransactionList.isEmpty) {
          return const Center(child: Text('No live loans are available.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: global.debtLiveTransactionList.length,
          itemBuilder: (BuildContext context, int index) {
            final DateFormat formatter = DateFormat('d-MMM-yy');
            String dateAndMonth =
                formatter.format(global.debtLiveTransactionList[index].date);

            return Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ListTile(
                title: Text(
                  '${global.debtLiveTransactionList[index].name} : ${global.debtLiveTransactionList[index].amount}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  dateAndMonth,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),

                trailing: global.getUser() == 'admin'
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // Call the createOrUpdateDebt function with docId
                              debtCrud.createOrUpdateDebt(
                                context,
                                existingDocId:
                                    global.debtLiveTransactionList[index].id,
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              // Call the deleteDebt function with docId
                              await debtCrud.deleteDebt(
                                global.debtLiveTransactionList[index].id,
                              );
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
                      )
                    : null, // No icons for non-admin users
                onTap: () {
                  // Navigate to the DebtDetailsPage when a row is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLoans(
                          name: global.debtLiveTransactionList[index].name),
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
