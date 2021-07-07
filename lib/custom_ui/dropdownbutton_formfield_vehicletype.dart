import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/VehicleDropdownListener.dart';
class DropDownButton_Formfield_VehicleType extends StatefulWidget {
  const DropDownButton_Formfield_VehicleType({Key key}) : super(key: key);

  @override
  DropDownButton_Formfield_VehicleTypeState createState() =>DropDownButton_Formfield_VehicleTypeState();
}

//CountryDropdownListener

class DropDownButton_Formfield_VehicleTypeState extends State<DropDownButton_Formfield_VehicleType> {

  List<String> vehicleTypeList = <String>['Coupe', "SUV","Minivan","Sedan","Truck"];
  String dropDownVehicleType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<VehicleDropdownListener>(context,listen: false).changeVehicle(vehicle:  vehicleTypeList[0]);

  }

  @override
  Widget build(BuildContext context) {
    var vehicleListener = Provider.of<VehicleDropdownListener>(context);
    return  DropdownButtonFormField(
      isExpanded: true,
      value: vehicleListener.vehicle,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(8), // Added this
      ),
      onChanged: (String newValue) {
        Provider.of<VehicleDropdownListener>(context,listen: false).changeVehicle(vehicle:  newValue);
      },
      items: vehicleTypeList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
