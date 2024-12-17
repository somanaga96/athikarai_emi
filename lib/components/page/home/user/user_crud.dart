import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/global.dart';

class UserCrud extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController villageNameController = TextEditingController();
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> createOrUpdateUser(
    BuildContext context, {
    String? existingDocId,
  }) async {
    // If existingDocId is provided, fetch the existing user data
    if (existingDocId != null) {
      var docSnapshot = await user.doc(existingDocId).get();
      if (docSnapshot.exists) {
        var userData = docSnapshot.data() as Map<String, dynamic>;
        nameController.text = userData['name'] ?? '';
        numberController.text = userData['number'].toString() ?? '';
        villageNameController.text = userData['village name'] ?? '';
      }
    }

    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, StateSetter modalSetState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Add or Edit a Transaction',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: 'பெயர்', hintText: 'பெயர் '),
                  ),
                  TextField(
                    controller: numberController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                        labelText: 'அலைபேசி', hintText: 'அலைபேசி'),
                  ),
                  TextField(
                    controller: villageNameController,
                    decoration: const InputDecoration(
                        labelText: 'கிராமத்தின் பெயர்',
                        hintText: 'கிராமத்தின் பெயர் '),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all fields!'),
                              ),
                            );
                            return;
                          }

                          final int? num = int.tryParse(numberController.text);
                          if ((num == null || num < 0) &&
                              (numberController.text.length == 10)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid number!'),
                              ),
                            );
                            return;
                          }

                          if (existingDocId == null) {
                            await user.add({
                              'name': nameController.text,
                              'number': num,
                              'village name': villageNameController.text,
                            });
                          } else {
                            await user.doc(existingDocId).update({
                              'name': nameController.text,
                              'number': num,
                              'village name': villageNameController.text,
                            });
                          }

                          // Clear controllers after saving
                          numberController.text = '';
                          nameController.text = '';
                          villageNameController.text = '';
                          Navigator.pop(ctx);

                          // Refresh customer list
                          Provider.of<Global>(context, listen: false)
                              .fetchCustomerList();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> deleteUser(String docId) async {
    try {
      await user.doc(docId).delete();
    } catch (e) {
      print('Error deleting User: $e');
    }
  }
}
