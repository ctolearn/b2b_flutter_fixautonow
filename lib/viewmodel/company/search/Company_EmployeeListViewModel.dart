
import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_UserViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Company_EmployeeListViewModel  extends ChangeNotifier {
  ApiResponse<List<Company_UserViewModel>> apiResponse = ApiResponse();
  void  fetchUsers() async {
    ApiResponse<List<User>> _apiResponse = await WebRepository().fetchUser();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.EMPTY:
        apiResponse = ApiResponse.empty();
        break;
      case Status.ERROR:
        apiResponse = ApiResponse.error(message: _apiResponse.message);
        break;
      case Status.COMPLETED:
        apiResponse = ApiResponse.completed(_apiResponse.data.where((element) => element.type == "Employee").map((e) => Company_UserViewModel(user: e)).toList());
        break;
    }
    notifyListeners();
  }

  ApiResponse<User> fetchResponse = ApiResponse();
  void fetchUser({String id}) async{
    fetchResponse = ApiResponse.loading();
    ApiResponse _apiResponse = await WebRepository().fetchUserInformation(id);
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        fetchResponse = ApiResponse.completed(_apiResponse.data);
        break;
      case Status.ERROR:
        break;
      case Status.EMPTY:
        break;
    }
    notifyListeners();
  }


}
