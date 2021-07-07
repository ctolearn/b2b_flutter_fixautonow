

import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/SentBooking.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_SentViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Company_SentListViewModel extends ChangeNotifier {
  ApiResponse<List<Company_SentViewModel>> apiResponse = ApiResponse();
  fetchSentBooking()async{
    apiResponse = ApiResponse.loading();
    ApiResponse<List<SentBooking>> _apiResponse = await WebRepository().fetchSent();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        apiResponse = ApiResponse.completed(_apiResponse.data.map((e) => Company_SentViewModel(sentBooking: e)).toList());
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



  ApiResponse<String> crudResponse= new ApiResponse();
  void cancelBooking(String id) async{
/*    crudResponse = ApiResponse.loading(crudType: "delete");
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
    notifyListeners();*/
  }



  void resetCrud() async{
    Future.delayed(Duration.zero, () async {
      crudResponse = ApiResponse();
      notifyListeners();
    });

  }

/*  List<Company_SentViewModel> companySentListViewModel = [];
  Status status = Status.EMPTY;
  Status status_delete = Status.EMPTY;

  void fetchSentBooking() async {
    status = Status.LOADING;
    List<SentBooking> sentList = await WebService().fetchSent();
    notifyListeners();
    this.companySentListViewModel = sentList
        .map((item) => Company_SentViewModel(sentBooking: item))
        .toList();
    if (companySentListViewModel.isEmpty) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }
    notifyListeners();
  }*/
}
