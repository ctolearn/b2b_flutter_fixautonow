import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:b2b_flutter_fixautonow/model/Assigned.dart';
class Company_SelectedEmployeeListener extends ChangeNotifier{
  Assigned userItem;
  void selectedEmployee(Assigned userItem) {
    this.userItem = userItem;
    notifyListeners();
  }
  void reset() async{
    this.userItem = null;
    notifyListeners();
  }


}