
import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_UserViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Company_UsersListViewModel extends ChangeNotifier {
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
        apiResponse = ApiResponse.completed(_apiResponse.data.map((e) => Company_UserViewModel(user: e)).toList());
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

  ApiResponse<String> crudResponse= new ApiResponse();
  void deleteUser(String id) async{
    crudResponse = ApiResponse.loading(crudType: "delete");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module",()=>"company_users");
    mapData.putIfAbsent("func", () => "delete");
    mapData.putIfAbsent("id", () => id);
    mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
    var formData = new FormData.fromMap(mapData);
    ApiResponse<String> _output = await WebRepository().deleteData(formData);
    notifyListeners();
    switch(_output.status){
      case Status.ERROR:
        crudResponse = ApiResponse.error(crudType: "delete");
        break;
      case Status.COMPLETED:
        crudResponse = ApiResponse.completed(_output.data,crudType: "delete");
        break;
    }
    notifyListeners();
  }

  void resetCrud() async{
    Future.delayed(Duration.zero, () async {
      crudResponse = ApiResponse();
      notifyListeners();
    });

  }
/* List<Company_UsersViewModel> userListViewModel = [];
  Status status = Status.EMPTY;
  Status status_delete = Status.EMPTY;
  Status status_info = Status.EMPTY;

  void clear() async {
    status_info = Status.EMPTY;
    notifyListeners();
  }

  void fetchUsers() async {
    status = Status.LOADING;
    List<User> usersList = await WebService().fetchUser();
    notifyListeners();
    this.userListViewModel =
        usersList.map((item) => Company_UsersViewModel(user: item)).toList();
    if (usersList.length <= 0) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }
    notifyListeners();
  }

  User user;
  String mobileNumber, mobileCode;

  void setMobile(String number, String code) {
    this.mobileNumber = number;
    this.mobileCode = code;
  }

  void fetchUserInformation(String id) async {
    status_info = Status.LOADING;
    User user = await WebService().fetchUserInformation(id);
    notifyListeners();
    this.user = user;
    status_info = Status.COMPLETED;
    // this.userListViewModel = usersList.map((item) => Company_BranchUsersViewModel(user: item)).toList();

    notifyListeners();
  }

  bool empty(String data) {
    if (data.isEmpty) {
      return true;
    } else {
      return false;
    }
  }


  void saveUser({String id,
    User user,
    String password,
    messageCallBack messageCallBack}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (empty(user.firstname)) {
      messageCallBack.showMessage("Firstname is empty");
    } else if (empty(user.lastname)) {
      messageCallBack.showMessage("Lastname is empty");
    } else if (empty(mobileNumber)) {
      messageCallBack.showMessage("Mobile is empty");
    } else if (empty(user.mobile)) {
      messageCallBack.showMessage("Email is empty");
    } else if (mobileNumber.isEmpty) {
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
      String output = await WebService().saveBooking(formData);
    }

  }*/
}
