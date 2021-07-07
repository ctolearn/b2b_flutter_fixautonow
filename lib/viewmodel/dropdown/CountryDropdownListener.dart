import 'package:flutter/cupertino.dart';

class CountryDropdownListener extends ChangeNotifier {

  List<String> countryList = <String>['United States of America'];
  String country = 'United States of America';
  void changeCountry({String country}) {
    Future.delayed(Duration.zero, () {
      if(countryList.contains(country)){
        this.country = country;
      }else{
        this.country = countryList[0];
      }
      notifyListeners();
    });
  }
}
