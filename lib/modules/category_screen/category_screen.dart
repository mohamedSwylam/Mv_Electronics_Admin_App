import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/layout/cubit/states.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
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
                      child: Center(child: cubit.image==null ?Text('Category Image'):Image.memory(cubit.image)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        child: Text('Uptoad Image'), onPressed: cubit.pickImage),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 200,
                  child: Center(
                    child: TextField(
                      controller: cubit.catName,
                      decoration: InputDecoration(
                          label: Text('Enter Catergory Name'),
                          contentPadding: EdgeInsets.zero),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                      BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed:cubit.saveImageToDb,
                  child: Text(
                    '  Save  ',
                  ),

                ),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Category List',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}
