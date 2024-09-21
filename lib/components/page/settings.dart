import 'package:athikarai_emi/components/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
        builder: (context, global, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.lightBlue,
                title: const Center(
                  child: Text(
                    "Settings",
                  ),
                ),
              ),
              body: IconButton(
                onPressed: () {
                  global.toggleTheme();
                },
                icon: Icon(global.isDarkMode
                    ? Icons.dark_mode_rounded
                    : Icons.wb_sunny),
              ),
            ));
  }
}
