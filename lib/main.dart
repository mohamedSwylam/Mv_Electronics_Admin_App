import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:mv_admin_app/shared/bloc_observer.dart';
import 'package:mv_admin_app/shared/network/local/cache_helper.dart';
import 'package:sizer/sizer.dart';
import 'layout/app_layout.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'modules/category_screen/category_screen.dart';
import 'modules/dashboard_screen/dashboard_screen.dart';
import 'modules/main_category_screen/main_category_screen.dart';
import 'modules/sub_category_screen/sub_category_screen.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
              builder: (context, orientation, deviceType) {
                return MaterialApp(
                  title: 'admin App',
                  builder: EasyLoading.init(),
                  theme: ThemeData(
                    primaryColor: Colors.indigo,
                    primarySwatch: Colors.indigo,
                  ),
                  debugShowCheckedModeBanner: false,
                  routes: {
                    'CategoryScreen' : (context) => CategoryScreen(),
                    'MainCategoryScreen' : (context) => MainCategoryScreen(),
                    'SubCategoryScreen' : (context) => SubCategoryScreen(),
                    'DashBoardScreen' : (context) => DashBoardScreen(),
                    'AppLayout' : (context) => AppLayout(),
                  },
                  initialRoute: 'AppLayout',
                );
              }
          );
        },
      ),
    );
  }
}


