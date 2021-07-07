

import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/AddOn.dart';
import 'package:b2b_flutter_fixautonow/model/Book_AddOn.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Company_AddOnViewModel.dart';
class Company_AddOnListViewModel extends ChangeNotifier{
  ApiResponse<List<Company_AddOnViewModel>> apiResponse = new ApiResponse();
  ApiResponse<String> crudResponse= new ApiResponse();
  ApiResponse<AddOn> fetchResponse = ApiResponse();

  void fetchAddOn({String id}) async{
    fetchResponse = ApiResponse.loading();
    ApiResponse _apiResponse = await WebRepository().fetchAddOnInformation(id);
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


  void fetchAddOnList()async{

    crudResponse = ApiResponse();
    apiResponse = ApiResponse.loading();
    ApiResponse<List<AddOn>> _apiResponse = await WebRepository().fetchAddOn();
    notifyListeners();
    print(_apiResponse.status);

    switch(_apiResponse.status){
      case Status.ERROR:
        apiResponse = ApiResponse.error();
        break;
      case Status.COMPLETED:
        List<AddOn> list = _apiResponse.data;
        apiResponse = ApiResponse.completed(list.map((e) => Company_AddOnViewModel(addOn: e)).toList());
        break;
      case Status.EMPTY:
        apiResponse = ApiResponse.empty();
        break;

    }
    notifyListeners();


  }
  void deleteOutlier(String id) async{

    crudResponse = ApiResponse.loading(crudType: "delete");
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    }
    notifyListeners();
  }
  void resetCrud() async{
    Future.delayed(Duration.zero, () async {
      crudResponse = ApiResponse();
      notifyListeners();
    });

  }

/*  AddOn addOn;
  void  fetchAddOnInformation(String id) async{
    // return List<ServiceItem>.empty();
    status_info = Status.LOADING;
    AddOn addOn = await WebService().fetchAddOnInformation(id);
    notifyListeners();
    this.addOn = addOn;
    status_info = Status.COMPLETED;
    notifyListeners();

  }
  bool empty(String data){
    if(data.isEmpty){
      return true;
    }else{
      return false;
    }
  }*/
/*



  void saveAddOn({String id,AddOn addOn,messageCallBack messageCallBack}) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> mapData = new Map();
    String addon_name = addOn.addon_name;
    String addon_price = addOn.addon_price;
    String addon_description = addOn.addon_description;
    if(empty(addon_name)){
      messageCallBack.showMessage("AddOn name is empty");
    }else if(empty(addon_description)){
      messageCallBack.showMessage("AddOn description is empty");
    }else if(empty(addon_price)){
      messageCallBack.showMessage("AddOn price is empty");
    }else{
      mapData.putIfAbsent("addon_name",()=>addon_name);
      mapData.putIfAbsent("addon_price",()=>addon_price);
      mapData.putIfAbsent("addon_description",()=>addon_description);
      mapData.putIfAbsent("func",()=> id == null ? "insert" : "update");
      mapData.putIfAbsent("id",()=>id == null ? "" : id);
      mapData.putIfAbsent("func",()=>id == null ? "insert":"update");
      mapData.putIfAbsent("module",()=>"company_addon");
      mapData.putIfAbsent("company_id", () => prefs.getString('current_company'));
      print("company id : "+prefs.getString('current_company'));
      var formData = new FormData.fromMap(mapData);
      String output = await WebService().saveBooking(formData);


    }

  }

 */





}