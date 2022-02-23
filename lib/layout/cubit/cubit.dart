import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_admin_app/layout/cubit/states.dart';
import 'package:mv_admin_app/modules/category_screen/category_screen.dart';
import 'package:mv_admin_app/modules/dashboard_screen/dashboard_screen.dart';
import 'package:mv_admin_app/modules/main_category_screen/main_category_screen.dart';
import 'package:mv_admin_app/modules/sub_category_screen/sub_category_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Widget selectorScreen = DashBoardScreen();

  screenSelector(item) {
    switch (item.route) {
      case 'DashBoardScreen':
        selectorScreen = DashBoardScreen();
        emit(ScreenSelectorState());
        break;
      case 'CategoryScreen':
        selectorScreen = CategoryScreen();
        emit(ScreenSelectorState());
        break;
      case 'MainCategoryScreen':
        selectorScreen = MainCategoryScreen();
        emit(ScreenSelectorState());
        break;
      case 'SubCategoryScreen':
        selectorScreen = SubCategoryScreen();
        emit(ScreenSelectorState());
        break;
    }
  }
}
