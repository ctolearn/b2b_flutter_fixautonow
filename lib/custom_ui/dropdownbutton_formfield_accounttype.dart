import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/AccountTypeDropdownListener.dart';
class DropDownButton_Formfield_AccountType extends StatefulWidget {
  DropDownButton_Formfield_AccountType({Key key}) : super(key: key);

  @override
  DropDownButton_Formfield_AccountTypeState createState() => DropDownButton_Formfield_AccountTypeState();
}

//CountryDropdownListener

class DropDownButton_Formfield_AccountTypeState extends State<DropDownButton_Formfield_AccountType> {

  List<String> accountTypes =  <String>['Admin', "Employee"];
  String dropDownType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AccountTypeDropdownListener>(context,listen: false).changeAccountType(account:  accountTypes[0]);
  }

  @override
  Widget build(BuildContext context) {
    var accountTypeListener = Provider.of<AccountTypeDropdownListener>(context);
    return  DropdownButtonFormField(
      isExpanded: true,
      value: accountTypeListener.account,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(8), // Added this
      ),
      onChanged: (String newValue) {
        Provider.of<AccountTypeDropdownListener>(context,listen: false).changeAccountType(account:  newValue);
      },
      items: accountTypes
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
