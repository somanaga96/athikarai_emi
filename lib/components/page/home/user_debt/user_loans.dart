import 'package:athikarai_emi/components/page/home/user_debt/user_closed_loans.dart';
import 'package:athikarai_emi/components/page/home/user_debt/user_live_loans.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global.dart';

class UserLoans extends StatefulWidget {
  final String name;

  const UserLoans({super.key, required this.name});

  @override
  State<UserLoans> createState() => _UserLoansState();
}

class _UserLoansState extends State<UserLoans> {
  bool showFirstView = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false).fetchUserDebtList(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<Global>(
      builder: (context, global, child) => Scaffold(
        appBar: AppBar(
          title: Text('${widget.name} Details'),
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
                        width: screenSize.width / 3,
                        height: screenSize.height / 10,
                        child: Column(
                          children: [
                            const Text('Debt detail'),
                            Text('Count :${global.userDebtCount}'),
                            Text('Total Loan :${global.userDebtSum}'),
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
              SizedBox(
                  width: screenSize.width,
                  height: screenSize.height / 2,
                  child: showFirstView
                      // ? const Center(child: Text('First View'))
                      ? UserLiveLoans(name: widget.name)
                      : UsedClosedLoans(name: widget.name)),
            ],
          ),
        ),
      ),
    );
  }
}
