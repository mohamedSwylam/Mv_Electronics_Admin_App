import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:path/path.dart';
import 'package:mime_type/mime_type.dart';

class CategoriesList extends StatelessWidget {
  final CollectionReference? reference;

  const CategoriesList({Key? key, this.reference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    return StreamBuilder<QuerySnapshot>(
      stream: reference!.snapshots(),
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

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
          ),
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            var data = snapshot.data!.docs[index];
            return CategoryWidget(data: data, reference: reference,);
          },
        );
      },
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final CollectionReference? reference;
  CategoryWidget({
    Key? key,
    required this.data,
    required this.reference,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;
  final FirebaseService service = FirebaseService();


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              width: 80,
              child: Image.network(data['image']),
            ),
            Text(reference==service.categories?data['catName']:data['subCatName']),
          ],
        ),
      ),
    );
  }
}
