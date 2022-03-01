import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:mv_admin_app/modules/category_screen/category_screen.dart';
import 'package:mv_admin_app/modules/dashboard_screen/dashboard_screen.dart';
import 'package:mv_admin_app/modules/main_category_screen/cubit/states.dart';
import 'package:mv_admin_app/modules/main_category_screen/main_category_screen.dart';
import 'package:mv_admin_app/modules/sub_category_screen/sub_category_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:path/path.dart';

class MainCatCubit extends Cubit<MainCatStates> {
  MainCatCubit() : super(MainCatInitialState());
  static MainCatCubit get(context) => BlocProvider.of(context);
  final FirebaseService service = FirebaseService();
  final TextEditingController mainCat = TextEditingController();
  bool noCategorySelected = false;
  QuerySnapshot? snapshot;
  Object? selectedValue;
  final TextEditingController catName = TextEditingController();
  final mainCatFormKey = GlobalKey<FormState>();
  void dropDownButtonChange(selectedCat) {
    selectedValue = selectedCat;
    noCategorySelected=false;
    emit(OnCategoryNameChangeSuccessStte());
  }
  clear() {
    catName.clear();
    emit(ClearSuccessState());
  }
  clearMainCat() {
    mainCat.clear();
    selectedValue = null;
    emit(ClearSuccessState());
  }
  addMainCat() {
    if (selectedValue == null) {
      noCategorySelected = true;
      emit(CategorySelectedState());
      return;
    }
    if (mainCatFormKey.currentState!.validate()) {
      EasyLoading.show();
      service.saveCategory(
          data: {
            'category': selectedValue,
            'mainCategory': mainCat.text,
            'approved': true,
          },
          reference: service.mainCat,
          docName: mainCat.text).then((value) {
        EasyLoading.dismiss();
      });
    }
  }
  getCatList(){
    return service.categories.
    get().then ((QuerySnapshot querySnapshot) {
      snapshot=querySnapshot;
      emit(GetSubCategoryListState());
    });
  }
  showAllCategory(){
    selectedValue=null;
    emit(ShowAllCategoryState());
  }
}
