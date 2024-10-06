import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';

class DebtTransactions extends StatefulWidget {
  const DebtTransactions({super.key});

  @override
  State<DebtTransactions> createState() => _DebtTransactionsState();
}

class _DebtTransactionsState extends State<DebtTransactions> {
  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false).fetchDebtLiveTransactionList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) {
        if (global.debtLiveTransactionList.isEmpty) {
          // Show loading indicator if data is not yet loaded
          return const Center(child: CircularProgressIndicator());
        }

        // If data is loaded, display it in the list
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
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${global.debtLiveTransactionList[index].name} : ${global.debtLiveTransactionList[index].amount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          dateAndMonth,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
