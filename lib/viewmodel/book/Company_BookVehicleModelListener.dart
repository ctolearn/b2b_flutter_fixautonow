import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Vehicle_Make.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';

class Company_BookVehicleModelListener extends ChangeNotifier{
  ApiResponse<List<Vehicle_Make>> fetchVehicleListResponse = new ApiResponse();

  //List<Vehicle_Make> vehicleMakeList;
  void fetchVehicleModel() async {

    ApiResponse<List<Vehicle_Make>> _apiResponse =  await WebRepository().fetchVehicleModel();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.EMPTY:
        fetchVehicleListResponse = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchVehicleListResponse = ApiResponse.error(message: _apiResponse.message);
        break;
      case Status.COMPLETED:
        fetchVehicleListResponse = ApiResponse.completed(_apiResponse.data);
        break;
    }
    notifyListeners();
  }

}