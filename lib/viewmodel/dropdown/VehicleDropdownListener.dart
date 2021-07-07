import 'package:flutter/cupertino.dart';

class VehicleDropdownListener extends ChangeNotifier {

  String vehicle = "Coupe";
  List<String> vehicleTypeList = <String>['Coupe', "SUV","Minivan","Sedan","Truck"];
  void changeVehicle({String vehicle}) {
    Future.delayed(Duration.zero, () {
      if(vehicleTypeList.contains(vehicle)){
        this.vehicle = vehicle;
      }else {
        this.vehicle = vehicleTypeList[0];
      }
      notifyListeners();
    });
  }
}
