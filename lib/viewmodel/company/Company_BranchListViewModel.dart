import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Branch.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Company_BranchViewModel.dart';

class Company_BranchListViewModel extends ChangeNotifier {
  ApiResponse<List<Company_BranchViewModel>> apiResponse = new ApiResponse();
  void fetchBranchList() async{
    apiResponse = ApiResponse<List<Company_BranchViewModel>>.loading();
    ApiResponse<List<Branch>> _apiResponse = await WebRepository().fetchBranch();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.ERROR:
        apiResponse = ApiResponse.error();
        break;
      case Status.EMPTY:
        apiResponse = ApiResponse.empty();
        break;
      case Status.COMPLETED:
        apiResponse = ApiResponse.completed(_apiResponse.data.map((e) => Company_BranchViewModel(branch: e)).toList());
        break;
    }
    notifyListeners();

  }

  ApiResponse<String> crudResponse= new ApiResponse();
  void deleteBranch(String id) async{
    crudResponse = ApiResponse.loading(crudType: "delete");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module", () => "company_branches");
    mapData.putIfAbsent("func", () => "delete");
    mapData.putIfAbsent("id", () => id);
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

  ApiResponse<Branch> fetchResponse = ApiResponse();
  void fetchBranch({String id}) async{
    fetchResponse = ApiResponse.loading();
    ApiResponse _apiResponse = await WebRepository().fetchBranchInformation(id);
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

/*  Status status = Status.EMPTY;

  StreamController streamController = new StreamController<String>.broadcast();
  Stream<String>  get stream => streamController.stream;
  Sink get sink => streamController.sink;
  void setMobileSink(String mobile){
    sink.add(mobile);

  }

  void clear() async {
    status_info = Status.EMPTY;
    notifyListeners();
  }

  void fetchBranchList() async {
    status = Status.LOADING;
    List<Branch> brachesList = await WebService().fetchBranch();
    notifyListeners();
    this.branchViewListModel = brachesList
        .map((item) => Company_BranchViewModel(branch: item))
        .toList();
    if (branchViewListModel.isEmpty) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }
    notifyListeners();
  }

  Status status_delete = Status.EMPTY;

  void deleteItem(String id) async {
    status_delete = Status.LOADING;
    notifyListeners();
  }

  String mobileNumber, mobileCode;
  bool validMobile;

  void setMobile(String number, String code,bool isValid) async{
    this.mobileNumber = number;
    this.mobileCode = code;
    this.validMobile = isValid;
  }

  Status status_info = Status.EMPTY;
  Branch branch;

  void fetchBranchInfo(String id) async {
    status_info = Status.LOADING;
    Branch branch = await WebService().fetchBranchInformation(id);
    notifyListeners();
    this.branch = branch;
    status_info = Status.COMPLETED;
    notifyListeners();


  }

  String code, number;

  void setContact(String number, String code) {}

  bool empty(String data) {
    if (data.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
  void deleteBranch(String id) async{
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module", () => "company_branches");
    mapData.putIfAbsent("func", () => "delete");
    mapData.putIfAbsent("id", () => id);
    var formData = new FormData.fromMap(mapData);
    String output = await WebService().deleteData(formData);

  }
  void saveBranch(
      {String id, Branch branch, messageCallBack messageCallBack}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (empty(branch.email)) {
      messageCallBack.showMessage("Branch Email is empty");
    }else if (empty(branch.address)) {
      messageCallBack.showMessage("Branch Address is empty");
    } else if (empty(branch.country)) {
      messageCallBack.showMessage("Branch Country is empty");
    } else if (empty(branch.city)) {
      messageCallBack.showMessage("Branch City is empty");
    } else if (empty(branch.state)) {
      messageCallBack.showMessage("Branch State is empty");
    } else if (empty(branch.contact)) {
      messageCallBack.showMessage("Branch Contact is empty");
    } else if (empty(branch.description)) {
      messageCallBack.showMessage("Branch Description is empty");
    }  else {
      PhoneService.parsePhoneNumber(branch.contact, branch.c_code)
          .then((isValid) async {
          if(!isValid){
            messageCallBack.showMessage("Not valid owner mobile number ");

          }else{
            Map<String, dynamic> mapData = new Map();
            mapData.putIfAbsent("branch_email", () => branch.email);
            mapData.putIfAbsent("branch_address", () => branch.address);
            mapData.putIfAbsent("branch_country", () => branch.country);
            mapData.putIfAbsent("branch_city", () => branch.city);
            mapData.putIfAbsent("branch_state", () => branch.state);
            mapData.putIfAbsent("branch_contact", () => mobileNumber);
            mapData.putIfAbsent("branch_description", () => branch.description);
            mapData.putIfAbsent("branch_c_code", () => mobileCode);
            mapData.putIfAbsent("id", () => id == null ? "" : id);
            mapData.putIfAbsent("func", () => id == null ? "insert" : "update");
            mapData.putIfAbsent("module", () => "company_branches");
            mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
            var lat = "38.609858";
            var lang = "-100.810901";
            mapData.putIfAbsent("latitude", () => lat);
            mapData.putIfAbsent("longitude", () => lang);
            var formData = new FormData.fromMap(mapData);
            String output = await WebService().saveBooking(formData);
          }

      });


    }

  }*/
}
