import 'package:athikarai_emi/components/page/home/debts/closed_loans.dart';
import 'package:athikarai_emi/components/page/home/user_debt/user_crud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/global.dart';
import 'open_loans.dart';

class DebtDetailPage extends StatefulWidget {
  final String debtStatus;

  const DebtDetailPage({super.key, required this.debtStatus});

  @override
  State<DebtDetailPage> createState() => _DebtDetailPageState();
}

class _DebtDetailPageState extends State<DebtDetailPage> {
  UserCrud userCrud = new UserCrud();
  late bool showFirstView;

  @override
  void initState() {
    super.initState();
    showFirstView = widget.debtStatus == 'Live Debt';
    Provider.of<Global>(context, listen: false).fetchDebtList();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<Global>(
      builder: (context, global, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            showFirstView ? 'Live Debt Details' : 'Closed Debt Details',
          ),
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
                            Text(
                                'Count: ${showFirstView ? global.debtLiveCount : global.debtClosedCount}'),
                            Text(
                                'Amount: ${showFirstView ? global.debtLiveSum : global.debtClosedSum}'),
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
                      child: const ClosedLoans(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => userCrud.createOrUpdateDebt(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
