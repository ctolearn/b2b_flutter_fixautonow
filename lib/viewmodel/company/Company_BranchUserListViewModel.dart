import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchUsersViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Company_BranchUsersListViewModel extends ChangeNotifier {
  ApiResponse<List<Company_BranchUsersViewModel>> fetchBranchUserList = new ApiResponse();
  void fetchBranchUsers(String company_id) async {
    fetchBranchUserList = ApiResponse.loading();
    ApiResponse<List<User>> _apiResponse = await WebRepository().fetchBranchUser(company_id);
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        fetchBranchUserList = ApiResponse.completed(_apiResponse.data.map((e) => Company_BranchUsersViewModel(user: e)).toList());
        break;
      case Status.EMPTY:
        fetchBranchUserList = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchBranchUserList = ApiResponse.error();
        break;

    }
    notifyListeners();
  }

  ApiResponse<String> crudApiResponse = ApiResponse();
  void deleteUser(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module", () => "company_users");
    mapData.putIfAbsent("func", () => "delete");
    mapData.putIfAbsent("id", () => id);
    mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
    var formData = new FormData.fromMap(mapData);
    crudApiResponse = ApiResponse.loading();
    ApiResponse<String> _apiResponse = await WebRepository().deleteData(formData);
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        crudApiResponse = ApiResponse.completed(_apiResponse.data);
        break;
      case Status.EMPTY:
        crudApiResponse = ApiResponse.empty();
        break;
      case Status.ERROR:
        crudApiResponse = ApiResponse.error();
        break;
    }
  }

/*  List<Company_BranchUsersViewModel> userListViewModel = [];
  Status status = Status.EMPTY;
  Status status_delete = Status.EMPTY;

  void fetchBranchUsers(String company_id) async {
    status = Status.LOADING;
    List<User> usersList = await WebService().fetchBranchUser(company_id);
    notifyListeners();
    this.userListViewModel = usersList
        .map((item) => Company_BranchUsersViewModel(user: item))
        .toList();
    if (usersList.length <= 0) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }
    notifyListeners();
  }*/
}
