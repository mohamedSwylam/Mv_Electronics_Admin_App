import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/modules/main_category_screen/cubit/cubit.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:mv_admin_app/widget/drop_down_button.dart';
import 'package:path/path.dart';
import 'package:mime_type/mime_type.dart';

class MainCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var cubit = MainCatCubit.get(context);
    return Column(
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
                        value: e['catName'],
                        child: Text(e['catName']),
                      );
                    }). toList(),
                    onChanged: (value)=>cubit.dropDownButtonChange(value),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cubit.showAllCategory();
                    },
                    child: Text('Show All'),
                  ),
                ],
              ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: service.mainCat
              .where('category', isEqualTo: cubit.selectedValue)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }
            if (snapshot.data!.size == 0) {
              return Text("No Main Categories Addded");
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 3,
                childAspectRatio: 6 / 2,
                mainAxisSpacing: 3,
              ),
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return MainCategoryWidget(data: data);
              },
            );
          },
        ),
      ],
    );
  }
}

class MainCategoryWidget extends StatelessWidget {
  const MainCategoryWidget({
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
        child: Center(child: Text(data['mainCategory'])),
      ),
    );
  }
}
