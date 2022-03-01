import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:mv_admin_app/layout/cubit/states.dart';
import 'package:mv_admin_app/modules/category_screen/category_screen.dart';
import 'package:mv_admin_app/modules/dashboard_screen/dashboard_screen.dart';
import 'package:mv_admin_app/modules/main_category_screen/main_category_screen.dart';
import 'package:mv_admin_app/modules/sub_category_screen/sub_category_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:path/path.dart';

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

  //// upload image
  dynamic image;
  String? fileName;
  String? url;
  final formKey = GlobalKey<FormState>();
  final FirebaseService service = FirebaseService();
  final TextEditingController catName = TextEditingController();

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false)
        .then((value) {
      if (value != null) {
        image = value.files.first.bytes;
        fileName = value.files.first.name;
        emit(PickedImageSuccessState());
      } else {
        //Failed to pick image. or user cancelled
        print('Cancelled Or Failed');
      }
    }).catchError((error) {
      emit(PickedImageErrorState(error.toString()));
    });
  }

  saveImageToDb() async {
    EasyLoading.show();
    var ref = firebase_storage.FirebaseStorage.instance
        .ref('categoryImage/$fileName');
    try {
      String? mimiType = mime(
        basename(fileName!),
      );
      var metaData = firebase_storage.SettableMetadata(contentType: mimiType);
      firebase_storage.TaskSnapshot uploadSnapshot =
      await ref.putData(image, metaData);
      await ref.putData(image); //now image will upload to firebase storage.
      //now need to get the download link of that image to save in fireStore
      String downloadURL =
      await uploadSnapshot.ref.getDownloadURL().then((value) {
        if (value.isNotEmpty) {
          url = value;
          service.saveCategory(
            data: {
              'catName': catName.text,
              'image': '$value.png',
              'active': true,
            },
            docName: catName.text,
            reference: service.categories,
          ).then((value) {
            clear();
            EasyLoading.dismiss();
          });
        }
        emit(SaveImageToDbSuccessState());
        //save data to firestore
        return value;
      });
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      emit(SaveImageToDbErrorState(e.toString()));
    }
  }

  clear() {
    catName.clear();
    image = null;
    emit(ClearSuccessState());
  }

  // main category screen
  Object? selectedValue;

  void dropDownButtonChange(selectedCat) {
    selectedValue = selectedCat;
    noCategorySelected=false;
    emit(OnCategoryNameChangeSuccessStte());
  }

  final TextEditingController mainCat = TextEditingController();
  final mainCatFormKey = GlobalKey<FormState>();

  clearMainCat() {
    mainCat.clear();
    selectedValue = null;
    emit(ClearSuccessState());
  }

  bool noCategorySelected = false;

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
  QuerySnapshot? snapshot;
  getCatList(){
    return service.categories.
    get().then ((QuerySnapshot querySnapshot) {
      snapshot=querySnapshot;
      });
    }
    showAllCategory(){
      snapshot=null;
      emit(ShowAllCategoryState());
    }
}
