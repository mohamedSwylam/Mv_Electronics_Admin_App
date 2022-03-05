import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mime_type/mime_type.dart';
import 'package:mv_admin_app/modules/category_screen/category_screen.dart';
import 'package:mv_admin_app/modules/dashboard_screen/dashboard_screen.dart';
import 'package:mv_admin_app/modules/main_category_screen/main_category_screen.dart';
import 'package:mv_admin_app/modules/sub_category_screen/cubit/states.dart';
import 'package:mv_admin_app/modules/sub_category_screen/sub_category_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mv_admin_app/modules/vendor_screen/cubit/states.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:path/path.dart';

class VendorCubit extends Cubit<VendorStates> {
  VendorCubit() : super(VendorInitialState());
  static VendorCubit get(context) => BlocProvider.of(context);
  bool? selectedButton;
  selectApproved(){
    selectedButton=true;
    emit(SelectApprovedState());
  }
  selectRejected(){
    selectedButton=false;
    emit(SelectRejectedState());
  }
  selectAll(){
    selectedButton=null;
    emit(SelectAllState());
  }

}
