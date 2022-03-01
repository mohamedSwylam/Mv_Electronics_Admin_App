import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/layout/cubit/states.dart';
import 'package:mv_admin_app/modules/sub_category_screen/cubit/cubit.dart';
import 'package:mv_admin_app/modules/sub_category_screen/cubit/states.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:mv_admin_app/widget/categories_list.dart';
import 'package:mv_admin_app/widget/drop_down_button.dart';
import 'package:mv_admin_app/widget/main_category_list.dart';

class SubCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCatCubit, SubCatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SubCatCubit.get(context);
        final FirebaseService service = FirebaseService();
        return Form(
          key: cubit.subCatFormKey,
          child: Column(
            children: [
              const Divider(
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sub Category',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade800),
                        ),
                        child: Center(
                            child: cubit.image == null
                                ? Text('Category Image')
                                : Image.memory(cubit.image)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          child: Text('Uptoad Image'),
                          onPressed: cubit.pickImage),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cubit.snapshot == null
                          ? const Text('Loading..')
                          : DropdownButton(
                        value: cubit.selectedValue,
                        hint: const Text('Select Category'),
                        items: cubit.snapshot!.docs.map((e) {
                          return DropdownMenuItem<String>(
                            value: e['mainCategory'],
                            child: Text(e['mainCategory']),
                          );
                        }).toList(),
                        onChanged: (value) => cubit.dropDownButtonChange(value),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      if (cubit.noCategorySelected == null)
                        Text(
                          "No Main Category Selected",
                          style: TextStyle(color: Colors.red),
                        ),
                      SizedBox(
                        width: 200,
                        child: Center(
                          child: TextFormField(
                            controller: cubit.subCatName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Sub Category Name';
                              }
                            },
                            decoration: InputDecoration(
                                label: Text('Enter Sub Catergory Name'),
                                contentPadding: EdgeInsets.zero),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              cubit.clear();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              side: MaterialStateProperty.all(
                                BorderSide(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if(cubit.image != null)
                          ElevatedButton(
                            onPressed: () {
                              //cubit.addMainCat();
                            },
                            child: const Text(
                              '  Save  ',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sub Category List',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CategoriesList(
                reference: service.subCat,
              ),
            ],
          ),
        );
      },
    );
  }
}
