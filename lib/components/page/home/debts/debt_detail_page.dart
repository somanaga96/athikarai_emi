import 'package:athikarai_emi/components/page/home/debts/closed_loans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';
import 'open_loans.dart';

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
    // Provider.of<Global>(context, listen: false).debt();
    Provider.of<Global>(context, listen: false).fetchDebtList();
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
                                Text(
                                  showFirstView
                                      ? 'Live Debt details'
                                      : 'Closed Debt details',
                                ),
                                Text(
                                    'Count: ${showFirstView ? global.debtLiveCount : global.debtClosedCount}'),
                                Text(
                                    'Amount: ${showFirstView ? global.debtLiveSum : global.debtClosedSum}'),
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
                  child: Text(showFirstView ? 'Open loans' : 'Closed loans'),
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
                      child: const OpenLoans(),
                    ),
                  ),
                  // Second view
                  Visibility(
                    visible: !showFirstView,
                    child: SizedBox(
                      width: screenSize.width,
                      height: screenSize.height / 2,
                      // Adjust height as needed
                      child: const ClosedLoans(),
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
