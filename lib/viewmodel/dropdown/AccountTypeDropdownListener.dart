import 'package:flutter/cupertino.dart';

class AccountTypeDropdownListener extends ChangeNotifier {
  String account = "Admin";
  List<String> accountTypes =  <String>['Admin', "Employee"];
  void changeAccountType({String account}) {
    Future.delayed(Duration.zero, () {
      if(accountTypes.contains(account)){
        this.account = account;
      }else{
        this.account = accountTypes[0];

      }
      notifyListeners();
    });
  }
}
