import 'package:athikarai_emi/components/navigation/bottom_navigation.dart';
import 'package:athikarai_emi/components/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/firestore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'components/page/home/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
            home: const LoginPage()));
    // home: const BottomNavigation()));
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Full Screen Toggle Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplitScreen(),
//     );
//   }
// }
//
// class SplitScreen extends StatefulWidget {
//   @override
//   _SplitScreenState createState() => _SplitScreenState();
// }
//
// class _SplitScreenState extends State<SplitScreen> {
//   bool showFirstView = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Full Screen Toggle'),
//       ),
//       body:
//       Stack(
//         children: [
//           // First view
//           Visibility(
//             visible: showFirstView,
//             child: Container(
//               color: Colors.greenAccent,
//               child: Center(child: Text('First View')),
//             ),
//           ),
//           // Second view
//           Visibility(
//             visible: !showFirstView,
//             child: Container(
//               color: Colors.lightBlueAccent,
//               child: Center(child: Text('Second View')),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             showFirstView = !showFirstView;
//           });
//         },
//         child: Icon(Icons.swap_horiz),
//         tooltip: 'Switch View',
//       ),
//     );
//   }
// }
