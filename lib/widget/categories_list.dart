import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mv_admin_app/services/firebase_services.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService service=FirebaseService();
    return StreamBuilder<QuerySnapshot>(
      stream: service.categories.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        if (snapshot.data!.size == 0) {
          return Text("No Categories Addded");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['catName']),
            );
          }).toList(),
        );
      },
    );
  }
}
