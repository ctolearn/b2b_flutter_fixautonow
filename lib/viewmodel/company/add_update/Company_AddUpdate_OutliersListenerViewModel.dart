import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Outliers.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';

class Company_AddUpdate_OutliersListenerViewModel extends ChangeNotifier{

  ApiResponse saveResponse = ApiResponse();

  void saveOutlier({Outliers outliers}){

  }
  void resetStatus(){
    saveResponse = ApiResponse();
    notifyListeners();
  }
}