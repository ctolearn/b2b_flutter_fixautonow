import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/CountryDropdownListener.dart';

class DropDownButton_Formfield_Country extends StatefulWidget {
  const DropDownButton_Formfield_Country({Key key}) : super(key: key);

  @override
  DropDownButton_Formfield_CountryState createState() =>DropDownButton_Formfield_CountryState();
}

//CountryDropdownListener

class DropDownButton_Formfield_CountryState extends State<DropDownButton_Formfield_Country> {

  List<String> countryList = <String>['United States of America'];
  String dropDownCountry = 'United States of America';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CountryDropdownListener>(context,listen: false).changeCountry(country:  countryList[0]);
  }




  @override
  Widget build(BuildContext context) {
    var countryListener = Provider.of<CountryDropdownListener>(context);
    return  DropdownButtonFormField(
      isExpanded: true,
      value:countryListener.country,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(8), // Added this
      ),
      onChanged: (String newValue) {
        Provider.of<CountryDropdownListener>(context,listen: false).changeCountry(country:  newValue);
      },
      items: countryList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
