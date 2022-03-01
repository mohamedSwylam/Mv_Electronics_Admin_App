import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/modules/sub_category_screen/cubit/cubit.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:mv_admin_app/widget/drop_down_button.dart';
import 'package:path/path.dart';
import 'package:mime_type/mime_type.dart';

class SubCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var cubit=SubCatCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          cubit.snapshot == null
              ? const Text('Loading..')
              : Row(
            children: [
              DropdownButton(
                value: cubit.selectedValue,
                hint: const Text('Select Category'),
                items: cubit.snapshot!.docs.map((e) {
                  return DropdownMenuItem<String>(
                    value: e['mainCategory'],
                    child: Text(e['mainCategory']),
                  );
                }).toList(),
                onChanged: (value) =>
                    cubit.dropDownButtonChange(value),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  cubit.showAllCategory();
                },
                child: const Text('Show All'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: service.subCat
                .where('mainCategory', isEqualTo: cubit.selectedValue)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }
              if (snapshot.data!.size == 0) {
                return const Text("No Main Categories Addded");
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
                  return SubCategoryWidget(data: data);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10,),
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(data['image']),
            ),
            Text(data['subCatName']),
          ],
        ),
      ),
    );
  }
}
