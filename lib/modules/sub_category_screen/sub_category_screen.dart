import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/layout/cubit/states.dart';
import 'package:mv_admin_app/modules/sub_category_screen/cubit/cubit.dart';
import 'package:mv_admin_app/modules/sub_category_screen/cubit/states.dart';

class SubCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCatCubit, SubCatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SubCatCubit.get(context);
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Sub Category',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        );
      },
    );
  }
}
