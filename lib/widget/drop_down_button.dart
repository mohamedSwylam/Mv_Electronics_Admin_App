import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:path/path.dart';
import 'package:mime_type/mime_type.dart';

class DropDownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    return FutureBuilder<QuerySnapshot>(
      future: service.categories.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return DropdownButton(
          value: AppCubit.get(context).selectedValue,
          hint: const Text('Select Category'),
          items: snapshot.data!.docs.map((e) {
            return DropdownMenuItem<String>(
              value: e['catName'],
              child: Text(e['catName']),
            );
          }). toList(),
          onChanged: (value)=>AppCubit.get(context).dropDownButtonChange(value),
        );
      },
    );
  }
}

