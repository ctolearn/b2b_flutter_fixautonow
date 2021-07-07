
import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Job.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Employee_JobViewModelList extends ChangeNotifier {
  ApiResponse<List<Employee_JobViewModel>> employeeJobViewModelList = new ApiResponse();

  void fetchJob(String type) async {
    employeeJobViewModelList = ApiResponse.loading();
    ApiResponse<List<Job>> _reponse  = await WebRepository().fetchJob(type);
    notifyListeners();
    switch(_reponse.status){
      case Status.ERROR:
        employeeJobViewModelList = ApiResponse.error();
        break;
      case Status.EMPTY:
        employeeJobViewModelList = ApiResponse.empty();
        break;
      case Status.COMPLETED:
        employeeJobViewModelList = ApiResponse.completed(_reponse.data.map((e) => Employee_JobViewModel(job: e)).toList());
        break;

    }
    notifyListeners();
 /*   status = Status.LOADING;
    List<Job> jobList = await WebService().fetchJob(type);
    notifyListeners();
    employeeJobViewModelList =
        jobList.map((e) => Employee_JobViewModel(job: e)).toList();
    if (employeeJobViewModelList.isEmpty) {
      status = Status.EMPTY;
      notifyListeners();
    } else {
      status = Status.COMPLETED;
      notifyListeners();
    }*/
  }


  void completeJob(String id) async{

    crudResponse = ApiResponse.loading(crudType: "delete");
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    Map<String, dynamic> mapData = new Map();
    mapData.putIfAbsent("module",()=>"company_addon");
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
    }*/
    notifyListeners();
  }


  ApiResponse<String> crudResponse= new ApiResponse();
  void resetCrud() async{
    Future.delayed(Duration.zero, () async {
      crudResponse = ApiResponse();
      notifyListeners();
    });

  }
}
