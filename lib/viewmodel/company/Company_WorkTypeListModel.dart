import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Company_WorkType.dart';
import 'package:b2b_flutter_fixautonow/model/WorkType.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Company_CompanyWorkTypeModel.dart';
import 'Company_WorkTypeModel.dart';

class Company_WorkTypeListModel extends ChangeNotifier {
  ApiResponse<List<Company_WorkTypeModel>> workListModel = new ApiResponse();
  ApiResponse<List<Company_CompanyWorkTypeModel>> fetchCompanyWorkType =
      new ApiResponse();

  void fetchWorkTypeList(String service_id) async {
    workListModel = ApiResponse.loading();
    ApiResponse<List<WorkType>> _apiResponse =
        await WebRepository().fetchWorkTypes(service_id);
    notifyListeners();
    switch (_apiResponse.status) {
      case Status.COMPLETED:
        if (choosenWorkModel.length == 0) {
          workListModel = ApiResponse.completed(_apiResponse.data
              .map((e) => Company_WorkTypeModel(workType: e))
              .toList());
        } else {
          for (int i = 0; i < _apiResponse.data.length; i++) {
            for (int j = 0; j < choosenWorkModel.length; j++) {
              if (_apiResponse.data[i].id == choosenWorkModel[j].workType.id) {
                _apiResponse.data[i].selected = true;
                break;
              }
            }
          }

          workListModel = ApiResponse.completed(_apiResponse.data
              .map((e) => Company_WorkTypeModel(workType: e))
              .toList());
        }
        break;
      case Status.ERROR:
        workListModel = ApiResponse.error();
        break;
      case Status.EMPTY:
        workListModel = ApiResponse.empty();
        break;
    }
    notifyListeners();
  }

  void fetchCompanyWorkTypeList(String service_id) async {
    ApiResponse<List<Company_WorkType>> _apiResponse =
        await WebRepository().fetchCompanyWorkTypes(service_id);
    notifyListeners();
    switch (_apiResponse.status) {
      case Status.COMPLETED:
        fetchCompanyWorkType = ApiResponse.completed(_apiResponse.data
            .map((e) => Company_CompanyWorkTypeModel(workType: e))
            .toList());
        break;
      case Status.ERROR:
        fetchCompanyWorkType = ApiResponse.error();
        break;
      case Status.EMPTY:
        fetchCompanyWorkType = ApiResponse.empty();
        break;
    }
    notifyListeners();
  }

  List<Company_WorkTypeModel> choosenWorkModel = [];

  void removeSelected(String id) {
    for (int i = 0; i < choosenWorkModel.length; i++) {
      if (choosenWorkModel[i].workType.id == id) {
        for (int j = 0; j < workListModel.data.length; j++) {
          if (workListModel.data[j].workType.id == id) {
            workListModel.data[j].workType.selected = false;
            break;
          }
        }

        choosenWorkModel.removeAt(i);
        notifyListeners();
        break;
      }
    }
  }

  void selectedWorkType(int pos) {
    for (int i = 0; i < workListModel.data.length; i++) {
      if (pos == i) {
        for(int j = 0 ; j < choosenWorkModel.length;j++){
          if (choosenWorkModel[j].workType.id == workListModel.data[pos].workType.id) {
            workListModel.data[i].workType.selected = false;
            choosenWorkModel.removeAt(j);
            notifyListeners();
            return;
          }
        }
        workListModel.data[i].workType.selected = true;
        choosenWorkModel.add(workListModel.data[i]);
        notifyListeners();
        return;
      }
    }
  }


  ApiResponse<String> crudResponse= new ApiResponse();
  void deleteWorkType(String id) async{
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

/* void fetchCompanyWorkTypeList(String service_id) async {
    company_status = Status.LOADING;
    List<Company_WorkType> workTypeList =
    await WebService().fetchCompanyWorkTypes(service_id);
    notifyListeners();
    companyWorkListModel = workTypeList
        .map((item) => Company_CompanyWorkTypeModel(workType: item))
        .toList();
    if (companyWorkListModel == null) {
      status = Status.ERROR;
      notifyListeners();
    } else {
      if (companyWorkListModel.length <= 0) {
        company_status = Status.EMPTY;
        notifyListeners();
      } else {
        company_status = Status.COMPLETED;
        notifyListeners();
      }
    }
  }*/
/*  List<Company_WorkTypeModel> workListModel;

  List<Company_CompanyWorkTypeModel> companyWorkListModel;

  Status status = Status.EMPTY;
  Status company_status = Status.EMPTY;

  void fetchWorkTypeList(String service_id) async {
    status = Status.LOADING;
    List<WorkType> workTypeList = await WebService().fetchWorkTypes(service_id);
    notifyListeners();
    workListModel = workTypeList
        .map((item) => Company_WorkTypeModel(workType: item))
        .toList();
    if (workListModel == null) {
      status = Status.ERROR;
      notifyListeners();
    } else {
      if (workListModel.length <= 0) {
        status = Status.EMPTY;
        notifyListeners();
      } else {
        status = Status.COMPLETED;
        notifyListeners();
      }
    }
  }

  void fetchCompanyWorkTypeList(String service_id) async {
    company_status = Status.LOADING;
    List<Company_WorkType> workTypeList =
        await WebService().fetchCompanyWorkTypes(service_id);
    notifyListeners();
    companyWorkListModel = workTypeList
        .map((item) => Company_CompanyWorkTypeModel(workType: item))
        .toList();
    if (companyWorkListModel == null) {
      status = Status.ERROR;
      notifyListeners();
    } else {
      if (companyWorkListModel.length <= 0) {
        company_status = Status.EMPTY;
        notifyListeners();
      } else {
        company_status = Status.COMPLETED;
        notifyListeners();
      }
    }
  }

  void selectedWorkType(int pos) {
    for (int i = 0; i < workListModel.length; i++) {
      if (pos == i) {
        workListModel[i].workType.selected = true;
      }
    }
    notifyListeners();
  }

  void removeSelected(String id) {
    for (int i = 0; i < workListModel.length; i++) {
      if (workListModel[i].workType.id == id) {
        workListModel[i].workType.selected = false;
      }
    }
    notifyListeners();
  }*/
}
