import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';

class UserLiveLoans extends StatefulWidget {
  final String name;

  const UserLiveLoans({super.key, required this.name});

  @override
  State<UserLiveLoans> createState() => _UserLiveLoansState();
}

class _UserLiveLoansState extends State<UserLiveLoans> {
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
    return Consumer<Global>(
      builder: (context, global, child) {
        // Check if it's still in the loading state
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // After the delay, check if the list is empty
        if (global.userDebtLiveTransactionList.isEmpty) {
          return Center(child: Text('${widget.name} not having live loans...'));
        }

        // If the list has data, display it
        return ListView.builder(
          shrinkWrap: true,
          itemCount: global.userDebtLiveTransactionList.length,
          itemBuilder: (BuildContext context, int index) {
            final DateFormat formatter = DateFormat('d-MMM-yy');
            String dateAndMonth = formatter
                .format(global.userDebtLiveTransactionList[index].date);
            return Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ListTile(
                title: Text(
                  '${global.userDebtLiveTransactionList[index].name} : ${global.userDebtLiveTransactionList[index].amount}',
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
