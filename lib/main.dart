import 'package:athikarai_emi/components/navigation/bottom_navigation.dart';
import 'package:athikarai_emi/components/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => Global(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
        builder: (context, global, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: global.getTitle(),
            theme: global.getTheme(),
            home: const BottomNavigation()));
  }
}
