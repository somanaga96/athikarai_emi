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
    Provider.of<Global>(context, listen: false).debt();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Center(
            child: Text(global.getTitle()),
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
