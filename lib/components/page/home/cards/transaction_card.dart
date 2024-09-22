import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final int count;
  final double amount;

  const TransactionCard({
    super.key,
    required this.title,
    required this.count,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String amountFormat = amount.toStringAsFixed(0);
    return Card(
      color: Colors.grey[1000],
      child: SizedBox(
        width: screenSize.width / 3.5,
        height: screenSize.height / 10,
        child: Column(
          children: [
            Column(
              children: [
                Text(title),
                Text('Count : $count'),
                Text('Amount: $amountFormat'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
