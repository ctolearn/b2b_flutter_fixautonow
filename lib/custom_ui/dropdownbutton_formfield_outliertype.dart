import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/OutlierTypeDropdownListener.dart';
class DropDownButton_Formfield_OutlierType extends StatefulWidget {
  const DropDownButton_Formfield_OutlierType({Key key}) : super(key: key);

  @override
  DropDownButton_Formfield_OutlierTypeState createState() =>DropDownButton_Formfield_OutlierTypeState();
}

//CountryDropdownListener

class DropDownButton_Formfield_OutlierTypeState extends State<DropDownButton_Formfield_OutlierType> {

  List<String> outlierTypeList = <String>['White List', "Black List"];
  String dropDownOutlierType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OutlierTypeDropdownListener>(context,listen: false).changeOutlier(outlier:outlierTypeList[0] );
  }

  @override
  Widget build(BuildContext context) {
    var outlierListener =   Provider.of<OutlierTypeDropdownListener>(context);

    return  DropdownButtonFormField(
      isExpanded: true,
      value: outlierListener.outlier,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(8), // Added this
      ),
      onChanged: (String newValue) {
        Provider.of<OutlierTypeDropdownListener>(context,listen: false).changeOutlier(outlier:newValue);
      },
      items: outlierTypeList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
