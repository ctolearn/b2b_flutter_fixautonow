import 'dart:io';

import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Service.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceViewModel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Company_ServiceListViewModel extends ChangeNotifier {
  ApiResponse<List<Company_ServiceViewModel>> apiResponse = new ApiResponse();
  void fetchServiceList() async {
    crudResponse = ApiResponse();
    apiResponse = ApiResponse.loading();
    ApiResponse<List<Service>> _apiResponse = await WebRepository().fetchService();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.EMPTY:
        apiResponse = ApiResponse.empty();
        break;
      case Status.ERROR:
        apiResponse = ApiResponse.error(message: _apiResponse.message);
        break;
      case Status.COMPLETED:
        apiResponse = ApiResponse.completed(_apiResponse.data.map((e) => Company_ServiceViewModel(service: e)).toList());
        break;
    }
    notifyListeners();
  }
  ApiResponse<String> crudResponse= new ApiResponse();
  void deleteService(String id) async{

    crudResponse = ApiResponse.loading(crudType: "delete");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module", () => "company_services");
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


  ApiResponse fetchResponse = ApiResponse();
  void fetchService({String id}) async{
    fetchResponse = ApiResponse.loading();
    ApiResponse _apiResponse = await WebRepository().fetchServiceInformation(id);
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


  void resetCrud() async{
    Future.delayed(Duration.zero, () async {
      crudResponse = ApiResponse();
      notifyListeners();
    });

  }


  File uploadimage; //variable for choosed file
  void getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if(result != null){
      uploadimage = File(result.files.single.path);
      notifyListeners();
    }
  }

/*
  List<Company_ServiceViewModel> serviceListViewModel = [];
  Status status = Status.EMPTY;
  Status status_delete = Status.EMPTY;
  Status status_info = Status.EMPTY;

  void fetchServiceList() async {

    status = Status.LOADING;
    List<Service> serviceList = await WebService().fetchService();
    notifyListeners();
    this.serviceListViewModel = serviceList
        .map((item) => Company_ServiceViewModel(service: item))
        .toList();
    if (serviceListViewModel.isEmpty) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }
    notifyListeners();
  }

  void getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
  }

  Service service;

  void fetchServiceInformation(String id) async {
    current_type = null;
    status_info = Status.LOADING;
    Service service = await WebService().fetchServiceInformation(id);
    notifyListeners();
    this.service = service;
    status_info = Status.COMPLETED;
    notifyListeners();
  }

  List<Company_WorkType> selected_companyWorkTypeList = [];

  void selectedService(Company_WorkType company_workType) {
    if (selected_companyWorkTypeList.length == 0) {
      selected_companyWorkTypeList.add(company_workType);
    } else {
      for (int i = 0; i < selected_companyWorkTypeList.length; i++) {
        Company_WorkType workType = selected_companyWorkTypeList[i];
        if (workType.work_id == company_workType.work_id) {
          return;
        }
      }
      selected_companyWorkTypeList.add(company_workType);
    }
    notifyListeners();
  }

  void removeSelected(Company_WorkType company_workType) {
    if (selected_companyWorkTypeList.length == 0) {
      return;
    } else {
      for (int i = 0; i < selected_companyWorkTypeList.length; i++) {
        Company_WorkType workType = selected_companyWorkTypeList[i];
        if (workType.work_id == company_workType.work_id) {
          selected_companyWorkTypeList.removeAt(i);
          notifyListeners();
          return;
        }
      }
    }
  }

  void resetInformation() async {
    selected_companyWorkTypeList = [];
    status_info = Status.EMPTY;
    await print("reset");
    notifyListeners();
  }

  bool empty(String data) {
    if (data.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String current_type;
  void setType(String type) async{
    this.current_type = type;
    notifyListeners();
  }


  void deleteService(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module", () => "company_services");
    mapData.putIfAbsent("func", () => "delete");
    mapData.putIfAbsent("id", () => id);
    mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
    var formData = new FormData.fromMap(mapData);
    String output = await WebService().deleteData(formData);

  }
  File fileImagefile;

  void saveService(
      {String id, Service service, messageCallBack messageCallBack}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (empty(service.service_name)) {
      messageCallBack.showMessage("Service name is empty");
    } else if (empty(service.vehicle_type)) {
      messageCallBack.showMessage("Vehicle type is empty");
    } else if (empty(service.service_category_id)) {
      messageCallBack.showMessage("Select category for your service");
    } else if (empty(service.service_start)) {
      messageCallBack.showMessage("Service time start availability");
    } else if (empty(service.service_end)) {
      messageCallBack.showMessage("Service time end availability");
    } else if (empty(service.service_approximate)) {
      messageCallBack.showMessage("Service estimated duration is empty");
    } else if (empty(service.service_description)) {
      messageCallBack.showMessage("Service description empty");
    } else {
      Map<String, dynamic> mapData = new Map();
      if (fileImagefile != null) {
        mapData.putIfAbsent(
            "img",
            () async => await MultipartFile.fromFile(fileImagefile.path,
                filename: fileImagefile.path.split("/").last
                //show only filename from path
                ));
      } else {
        mapData.putIfAbsent("img", () async => null);
      }

      mapData.putIfAbsent("service_name", () => service.service_name);
      mapData.putIfAbsent("time_start", () => service.service_start);
      mapData.putIfAbsent("time_end", () => service.service_end);
      mapData.putIfAbsent("duration", () => service.service_approximate);
      mapData.putIfAbsent("description", () => service.service_description);
      mapData.putIfAbsent("category_id", () => service.service_category_id);
      mapData.putIfAbsent("vehicle_type", () => service.vehicle_type);
      mapData.putIfAbsent("id", () => id == null ? "" : id);
      mapData.putIfAbsent("func", () => id == null ? "insert" : "update");
      mapData.putIfAbsent("module", () => "company_services");
      mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
      var formData = new FormData.fromMap(mapData);
      String output = await WebService().saveBooking(formData);
    }

  }*/
}
