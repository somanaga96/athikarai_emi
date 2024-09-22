import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/global.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<Global>(
        builder: (context, global, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              title: Center(
                child: Text(global.getTitle()),
              ),
            ),
            body: Card(
                color: Colors.grey[1000],
                // global.getTheme() ? Colors.grey[1000] : Colors.grey[1000],
                child: SizedBox(
                  width: screenSize.width / 2.1,
                  height: screenSize.height / 6,
                  child: const Column(
                    children: [
                      Column(
                        children: [
                          Text('Transaction: '),
                          // Text('Count : ${value.count.toString()}'),
                          // Text('Amount: ${value.sum.toString()}'),
                          // Text('date: ${value.selectedDate.toString()}'),
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
