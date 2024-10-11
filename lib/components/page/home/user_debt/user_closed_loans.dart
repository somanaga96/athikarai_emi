import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';

class UsedClosedLoans extends StatefulWidget {
  final String name;

  const UsedClosedLoans({
    super.key,
    required this.name,
  });

  @override
  State<UsedClosedLoans> createState() => _UsedClosedLoansState();
}

class _UsedClosedLoansState extends State<UsedClosedLoans> {
  bool isLoading = true; // To handle loading state
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
        // Check if it's still in the loading state
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // After the delay, check if the list is empty
        if (global.userDebtClosedTransactionList.isEmpty) {
          return Center(
              child: Text('${widget.name} not having closed loans...'));
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: global.userDebtClosedTransactionList.length,
          itemBuilder: (BuildContext context, int index) {
            final DateFormat formatter = DateFormat('d-MMM-yy');
            String dateAndMonth = formatter
                .format(global.userDebtClosedTransactionList[index].date);
            return Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ListTile(
                title: Text(
                  '${global.userDebtClosedTransactionList[index].name} : ${global.userDebtClosedTransactionList[index].amount}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  dateAndMonth,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
