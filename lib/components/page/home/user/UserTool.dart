import 'package:athikarai_emi/components/page/home/user/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserTool extends ChangeNotifier {
  Future<List<User>> fetchUserList() async {
    List<User> objectList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      // Check if there are documents in the querySnapshot
      print('Number of documents fetched: ${querySnapshot.docs.length}');

      for (var doc in querySnapshot.docs) {
        // Create the Debt object
        User yourObject = User(
            id: doc.id,
            name: doc.data()['name'],
            villageName: doc.data()['village name'],
            number: doc.data()['number']);
        objectList.add(yourObject);
      }

      // Notify listeners to update the UI
      notifyListeners();

      // Print the entire list
      print('Final User list: $objectList');
      return objectList;
    } catch (e) {
      // Print any errors for debugging
      print('Error fetching user transactions: $e');
      return [];
    }
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> usernameList = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // Fetch the username list from Firestore
  Future<void> fetchUsernames() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection('users').get();

      usernameList = querySnapshot.docs
          .map((doc) => doc.data()['name'] as String? ?? '')
          .toList();

      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      print('Error fetching usernames: $e');
    }
  }
}
