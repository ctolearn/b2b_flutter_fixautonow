import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Service_Item.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';
import 'ServicesAvailableViewModel.dart';
class ServicesAvailableListViewModel with ChangeNotifier{
  ApiResponse<List<ServicesAvailableViewModel>> fetchServiceAvailableModel = new ApiResponse();
  void fetchService(String query) async {
    fetchServiceAvailableModel = ApiResponse.loading();
    ApiResponse<List<ServiceItem>> _apiResponse = await WebRepository().fetchServiceItem(query);
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        fetchServiceAvailableModel = ApiResponse.completed(_apiResponse.data.map((e) => ServicesAvailableViewModel(serviceItem: e)).toList());
        break;
      case Status.ERROR:
        fetchServiceAvailableModel = ApiResponse.error();
        break;
      case Status.EMPTY:
        fetchServiceAvailableModel = ApiResponse.empty();
        break;
    }
    notifyListeners();

  }
}