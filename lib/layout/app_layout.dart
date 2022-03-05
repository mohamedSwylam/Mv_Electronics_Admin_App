import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return AdminScaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Electronic App Admin',style: TextStyle(letterSpacing: 1),),
          ),
          sideBar: SideBar(
            items: const [
              MenuItem(
                title: 'Dashboard',
                route: 'DashBoardScreen',
                icon: Icons.dashboard,
              ),
              MenuItem(
                title: 'Categories',
                icon: IconlyLight.category,
                children: [
                  MenuItem(
                    title: 'Category',
                    route: 'CategoryScreen',
                  ),
                  MenuItem(
                    title: 'Main Category',
                    route: 'MainCategoryScreen',
                  ),
                  MenuItem(
                    title: 'Sub Category',
                    route: 'SubCategoryScreen',
                  ),
                  MenuItem(
                    title: 'Vendor',
                    route: 'VendorScreen',
                    icon: Icons.group_add_outlined,
                  ),
                ],
              ),
            ],
            selectedRoute: 'AppLayout',
            onSelected: (item) {
              AppCubit.get(context).screenSelector(item);
              /*if (item.route != null) {
                Navigator.of(context).pushNamed(item.route!);
              }*/
            },
            header: Container(
              height: 50,
              width: double.infinity,
              color: const Color(0xff444444),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            footer: Container(
              height: 50,
              width: double.infinity,
              color: const Color(0xff444444),
              child:  Center(
                child:  Text(
                  '${DateTimeFormat.format(DateTime.now(),format: AmericanDateFormats.dayOfWeek)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: AppCubit.get(context).selectorScreen,
          ),
        );
      },
    );
  }
}
