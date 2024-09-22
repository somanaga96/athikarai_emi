import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreExample extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Read Example')),
      body: StreamBuilder(
        stream: firestore.collection('amount').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                  title: Text(data['name']), // Replace with your field
                  subtitle: Column(
                    children: [
                      Text(data['amount'].toString()),
                      Text(data['date'].toString()),
                    ],
                  )
                  // Replace with your field
                  );
            }).toList(),
          );
        },
      ),
    );
  }
}
