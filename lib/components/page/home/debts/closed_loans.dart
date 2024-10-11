import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';
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

    // Provider.of<Global>(context, listen: false).fetchUserDebtList(widget.name);

    // Simulating a delay before loading the data
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        isLoading = false; // After the delay, change the loading state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // After the delay, check if the list is empty
        if (global.debtClosedTransactionList.isEmpty) {
          return const Center(child: Text('No live loans are available.'));
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
