import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/layout/cubit/states.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:mv_admin_app/widget/drop_down_button.dart';

class MainCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Form(
          key: cubit.mainCatFormKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Main Category Screen',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                cubit.snapshot==null ? Text("Loading.."):
                DropDownButton(),
                SizedBox(
                  height: 8,
                ),
                if(cubit.noCategorySelected==null)
                Text(
                  "No Category Selected",
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  width: 200,
                  child: Center(
                    child: TextFormField(
                      controller: cubit.mainCat,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Main Category Name';
                        }
                      },
                      decoration: InputDecoration(
                          label: Text('Enter Main Catergory Name'),
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
                    ElevatedButton(
                      onPressed: (){
                        cubit.onPressSave();
                      },
                      child: const Text(
                        '  Save  ',
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
