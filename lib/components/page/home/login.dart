import 'package:athikarai_emi/components/navigation/bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Global global = Global();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      // Get the shared instance of Global
      final global = Provider.of<Global>(context, listen: false);

      global.setUser(username);
      print('Current user set in login page: ${global.getUser()}');
      // Static credentials
      const staticCredentials = {
        'admin': 'admin',
        'user': 'user',
      };

      try {
        // Check against static credentials
        if (staticCredentials.containsKey(username) &&
            staticCredentials[username] == password) {
          if (!mounted) return;
          // Navigate to another page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()),
          );
          return;
        }

        // Query user data from Firestore if static check fails
        var querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('userName', isEqualTo: username)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data();
          if (userData['password'].toString() == password) {
            if (!mounted) return;
            // Navigate to another page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavigation()),
            );
          } else {
            _showError('Invalid username or password');
          }
        } else {
          _showError('User does not exist');
        }
      } catch (e) {
        _showError('An error occurred while logging in');
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(title: const Text('Login Page')),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
