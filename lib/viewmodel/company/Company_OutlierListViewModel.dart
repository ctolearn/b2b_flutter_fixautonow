import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Outliers.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_OutliersViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Company_OutlierListViewModel extends ChangeNotifier {

  ApiResponse<List<Company_OutliersViewModel>> apiResponse = ApiResponse();
  void fetchOutliers()async{
    apiResponse = ApiResponse.loading();
    ApiResponse<List<Outliers>> _apiResponse =  await WebRepository().fetchOutliers();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        apiResponse = ApiResponse.completed(_apiResponse.data.map((e) => Company_OutliersViewModel(outliers: e)).toList());
        break;
      case Status.ERROR:
        apiResponse = ApiResponse.error();
        break;
      case Status.EMPTY:
        apiResponse = ApiResponse.empty();
        break;
    }
    notifyListeners();
  }
  ApiResponse fetchResponse = ApiResponse();
  void fetchOutlier({String id}) async{
    fetchResponse = ApiResponse.loading();
    ApiResponse _apiResponse = await WebRepository().fetchOutlierInformation(id);
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
  void deleteOutlier(String id) async{
    crudResponse = ApiResponse.loading(crudType: "delete");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module", () => "company_outliers");
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
/*  List<Company_OutlierViewModel> outlierListViewModel = [];
  Status status = Status.EMPTY;
  Status status_delete = Status.EMPTY;
  Status status_info = Status.EMPTY;

  void fetchOutliers() async {
    status = Status.LOADING;
    List<Outliers> outlierList = await WebService().fetchOutliers();
    notifyListeners();
    this.outlierListViewModel = outlierList
        .map((item) => Company_OutlierViewModel(outlier: item))
        .toList();
    if (outlierListViewModel.length <= 0) {
      status = Status.EMPTY;
    } else {
      status = Status.LOADING;
    }
    notifyListeners();
  }

  void clear() async {
    status_info = Status.EMPTY;
    notifyListeners();
  }

  Outliers outliers;

  void fetchOutliersInformation(String id) async {

    current_type = null;
    status_info = Status.LOADING;
    Outliers outliers = await WebService().fetchOutlierInformation(id);
    notifyListeners();
    this.outliers = outliers;
    status_info = Status.COMPLETED;

    notifyListeners();
  }
  String current_type;
  void setType(String type) async{
    this.current_type = type;
    notifyListeners();
  }
  void deleteOutlier(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module", () => "company_outliers");
    mapData.putIfAbsent("func", () => "delete");
    mapData.putIfAbsent("id", () => id);
    mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
    var formData = new FormData.fromMap(mapData);
    String output = await WebService().deleteData(formData);
  }
  void saveOutlier(
      {String id,
        String company_id,
        String type,
      messageCallBack messageCallBack}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (company_id == null) {
      messageCallBack.showMessage("Select company to make outlier");
    } else {
      Map<String, dynamic> mapData = new Map();
      mapData.putIfAbsent("outlier_type", () => current_type);
      mapData.putIfAbsent("outlier_id", () => id == null ? "" : id);
      mapData.putIfAbsent("outlier_company_id", () => company_id);
      mapData.putIfAbsent("func", () => id == null ? "insert" : "update");
      mapData.putIfAbsent("module", () => "company_outliers");
      mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
      var formData = new FormData.fromMap(mapData);
      String output = await WebService().saveBooking(formData);
    }

  }*/
}
