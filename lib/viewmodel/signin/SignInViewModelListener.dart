import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/screens/signinscreen/SignInScreenView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignInView.dart';

class SignInViewModelListener extends ChangeNotifier implements SignInView {
  WebRepository webRepository;
  ApiResponse<CurrentUser> apiResponse = ApiResponse();
  BuildContext context;

  SignInViewModelListener({this.context}) {
    webRepository = new WebRepository();
  }

  @override
  signIn(
      String email, String password, SignInScreenView signInScreenView) async {
    if (email.isEmpty) {
      signInScreenView.showMessage("Empty Field", "Email is empty");
      return;
    } else if (password.isEmpty) {
      signInScreenView.showMessage("Empty Field", "Password is empty");
      return;
    }
    apiResponse = ApiResponse.loading();
    notifyListeners();
    // TODO: implement signIn
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("email", () => email);
    mapData.putIfAbsent("password", () => password);
    mapData.putIfAbsent("func", () => "sign_in");
    FormData formData = FormData.fromMap(mapData);
    ApiResponse _response = await webRepository.signIn(formData);

    switch (_response.status) {
      case Status.ERROR:
        apiResponse = ApiResponse.error(message:_response.message);
        if(apiResponse.message != null){
          signInScreenView.showMessage("Failed",apiResponse.message);
        }
        notifyListeners();
        break;
      case Status.COMPLETED:
        saveCurrentUser(_response.data).then((value){
          apiResponse = _response;
          print(_response.data);
          CurrentUser currentUser = _response.data ;
          signInScreenView.moveToScreen(currentUser.current_role);
        });

        notifyListeners();
        break;
    }



  }

  @override
  Future<void> saveCurrentUser(CurrentUser currentUser) async {
    // TODO: implement saveCurrentUser
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("current_role", currentUser.current_role ?? "empty");
    prefs.setString("current_status", currentUser.current_status ?? "empty");
    prefs.setString("current_email", currentUser.current_email ?? "empty");
    prefs.setString("current_company", currentUser.current_company ?? "empty");
    prefs.setString("current_id", currentUser.current_id ?? "empty");
  }
}
