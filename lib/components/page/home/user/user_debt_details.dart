import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global.dart';

class UserDetails extends StatefulWidget {
  final String name;

  const UserDetails({super.key, required this.name});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false).userDebt(widget.name);
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
                            Column(
                              children: [
                                Text('Debt detail'),
                                Text('Count :${global.userDebtCount}'),
                                Text('Total Loan :${global.userDebtSum}'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
