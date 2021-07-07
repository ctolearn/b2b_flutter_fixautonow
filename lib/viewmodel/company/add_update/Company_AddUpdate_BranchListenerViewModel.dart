import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Branch.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';

class Company_AddUpdate_BranchListenerViewModel extends ChangeNotifier{

  ApiResponse saveResponse = ApiResponse();
  void saveBranch({Branch branch}){
    saveResponse = ApiResponse.loading();
    notifyListeners();

  }
  void resetStatus(){
    saveResponse = ApiResponse();
    notifyListeners();
  }
}