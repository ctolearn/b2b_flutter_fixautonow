
import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/ReceiveBooking.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';

import 'Company_ReceiveViewModel.dart';

class Company_ReceiveListViewModel extends ChangeNotifier {
  ApiResponse<List<Company_ReceiveViewModel>> apiResponse = new ApiResponse();
  void fetchReceiveBooking()async{
    apiResponse = ApiResponse.loading();
    ApiResponse<List<ReceiveBooking>> _apiResponse  = await WebRepository().fetchReceive();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.COMPLETED:
        apiResponse = ApiResponse.completed(_apiResponse.data.map((e) => Company_ReceiveViewModel(receiveBooking: e)).toList());
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

/* List<Company_ReceiveViewModel> companyReceiveListViewModel = [];
  Status status = Status.EMPTY;
  Status status_delete = Status.EMPTY;
  Status status_complete = Status.EMPTY;
  Status status_accomplish = Status.EMPTY;

  void fetchReceiveBooking() async {
    status = Status.LOADING;
    List<ReceiveBooking> receiveList = await WebService().fetchReceive();
    notifyListeners();
    this.companyReceiveListViewModel = receiveList
        .map((item) => Company_ReceiveViewModel(receiveBooking: item))
        .toList();
    if (companyReceiveListViewModel.isEmpty) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }
    notifyListeners();
  }

  void acceptBooking() async {}

  void  declineBooking(String booking_id) async {
    status_delete = Status.LOADING;
    print(booking_id);
    notifyListeners();
  }

  void completeBooking(String booking_id) async {
    status_complete = Status.LOADING;
    print(booking_id);
    notifyListeners();
  }*/
}
