import 'package:flutter/material.dart';

class TransactionDetailPage extends StatelessWidget {
  final String title;
  final int count;
  final double amount;

  const TransactionDetailPage({
    required this.title,
    required this.count,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              color: Colors.grey[1000],
              child: SizedBox(
                width: screenSize.width / 3.5,
                height: screenSize.height / 10,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(title),
                        Text('Count: $count'),
                        Text('Amount: \$${amount.toStringAsFixed(2)}')
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
