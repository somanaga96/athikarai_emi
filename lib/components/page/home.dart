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
    return Consumer<Global>(
        builder: (context, global, child) => Scaffold(
                appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              title: Center(
                child: Text(global.getTitle()),
              ),
            )
        ));
  }
}
