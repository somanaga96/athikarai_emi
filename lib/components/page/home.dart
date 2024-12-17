import 'package:athikarai_emi/components/page/home/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/global.dart';
import 'home/cards/horizontal_cards_scroll.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false).transactionTotal();
    Provider.of<Global>(context, listen: false).liveDebtCount();
    Provider.of<Global>(context, listen: false).liveDebtSum();
    Provider.of<Global>(context, listen: false).closedDebtCount();
    Provider.of<Global>(context, listen: false).closedDebtSum();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(global.getTitle()),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
        body: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CardHorizontalScrollView(),
            ],
          ),
        ),
      ),
    );
  }
}
