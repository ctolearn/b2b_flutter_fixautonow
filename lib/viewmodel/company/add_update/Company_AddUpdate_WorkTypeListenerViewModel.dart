import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_WorkTypeModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Company_AddUpdate_WorkTypeListenerViewModel  extends ChangeNotifier{


  ApiResponse<String> saveResponse = ApiResponse();


  void saveWorkType({List<Company_WorkTypeModel> workList}) async {
    saveResponse = ApiResponse.loading();
    notifyListeners();
/*
    Future.delayed(Duration.zero, () async {

      notifyListeners();
    });*/
  /*  SharedPreferences prefs = await SharedPreferences.getInstance();
    if (empty(user.firstname)) {
      messageCallBack.showMessage("Firstname is empty");
    } else if (empty(user.lastname)) {
      messageCallBack.showMessage("Lastname is empty");
    } else if (empty(user.mobile)) {
      messageCallBack.showMessage("Mobile is empty");
    } else if (empty(user.mobile)) {
      messageCallBack.showMessage("Email is empty");
    } else if (!isValidNumber) {
      messageCallBack.showMessage("Not valid owner mobile number ");
    } else {
      Map<String, dynamic> mapData = new Map();
      if (id == null) {
        if (empty(password)) {
          messageCallBack.showMessage("Password is empty");
          return;
        }
      } else {
        mapData.putIfAbsent("account_password", () => password);
      }

      mapData.putIfAbsent("account_firstname", () => user.firstname);
      mapData.putIfAbsent("account_lastname", () => user.lastname);
      mapData.putIfAbsent("account_mobile", () => user.mobile);
      mapData.putIfAbsent("account_email", () => user.email);
      mapData.putIfAbsent("account_type", () => user.type);
      mapData.putIfAbsent("c_code", () => user.c_code);
      mapData.putIfAbsent("id", () => id == null ? "" : id);
      mapData.putIfAbsent("func", () => id == null ? "insert" : "update");
      mapData.putIfAbsent("module", () => "company_users");
      mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
      var formData = new FormData.fromMap(mapData);
      ApiResponse<String> output = await WebRepository().saveUser(formData);
    }
*/
  }
}