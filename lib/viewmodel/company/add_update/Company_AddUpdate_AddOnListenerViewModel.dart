import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/AddOn.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';

class Company_AddUpdate_AddOnListenerViewModel extends ChangeNotifier{
  ApiResponse<String> saveResponse = ApiResponse();
  void saveAddOn({AddOn addOn,MessageCallBack messageCallBack}) async{
    saveResponse = ApiResponse.loading();
    notifyListeners();

  }
  void resetStatus(){
    saveResponse = ApiResponse();
    notifyListeners();
  }
}