import 'package:athikarai_emi/components/page/home/login.dart';
import 'package:athikarai_emi/components/page/home/user/customer_list.dart';
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
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Select the theme"),
                      IconButton(
                        onPressed: () {
                          global.toggleTheme();
                        },
                        icon: Icon(global.isDarkMode
                            ? Icons.dark_mode_rounded
                            : Icons.wb_sunny),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("List of Users"),
                        IconButton(
                          onPressed: () {
                            global.toggleTheme();
                          },
                          icon:
                              const Icon(Icons.supervised_user_circle_outlined),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerList()),
                      );
                    },
                  ),
                ],
              ),
            ));
  }
}
