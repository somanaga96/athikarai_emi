import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';
import 'debt_transactions.dart';

class DebtDetailPage extends StatefulWidget {
  const DebtDetailPage({super.key});

  @override
  State<DebtDetailPage> createState() => _DebtDetailPageState();
}

class _DebtDetailPageState extends State<DebtDetailPage> {
  // Move the showFirstView to the state of the widget
  bool showFirstView = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false).debt();
    Provider.of<Global>(context, listen: false).debtLiveTransactionList;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<Global>(
      builder: (context, global, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Debt Details'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Card(
                      color: Colors.grey[1000],
                      child: SizedBox(
                        width: screenSize.width / 3.5,
                        height: screenSize.height / 10,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text('Count: ${global.debtCount}'),
                                Text(
                                    'Amount: \$${global.debtSum.toStringAsFixed(0)}'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showFirstView = !showFirstView; // Toggle the view
                    });
                  },
                  child: Text(
                      showFirstView ? 'Show Second View' : 'Show First View'),
                ),
              ),
              Stack(
                children: [
                  // First view
                  Visibility(
                    visible: showFirstView,
                    child: SizedBox(
                      width: screenSize.width,
                      height: screenSize.height / 2,
                      child: DebtTransactions(),
                    ),
                  ),
                  // Second view
                  Visibility(
                    visible: !showFirstView,
                    child: Container(
                      color: Colors.lightBlueAccent,
                      width: screenSize.width,
                      height: screenSize.height / 2,
                      // Adjust height as needed
                      child: const Center(child: Text('Second View')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
