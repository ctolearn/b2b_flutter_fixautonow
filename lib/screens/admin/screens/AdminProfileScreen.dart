import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';

class AdminProfileScreen extends StatefulWidget {
  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String phoneNumber;
  String phoneIsoCode;

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
      String isoCode, String dial, bool isValid) {
    print(isValid.toString());
  }

  Widget mobileWidget;
  String mobileCode = "+1";
  TextEditingController mobileController = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    if(true == true){
      mobileCode = "+1";
      mobileWidget = InternationalPhoneInputController(
        controller: mobileController,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: mobileCode,
        removeDuplicates: ["CA"],
        enabledCountries: ['+1'],
        showCountryCodes: true,
        showCountryFlags: true,
        withError: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        ),
      );
    }else{
      mobileWidget = InternationalPhoneInputController(
        controller: mobileController,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: mobileCode,
        removeDuplicates: ["CA"],
        enabledCountries: ['+1'],
        showCountryCodes: true,
        showCountryFlags: true,
        withError: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      children: [
        Text("Owner First Name").boldText().blackColor(),
        CupertinoTextField(
          placeholder: "Johnatan",
        ),
        Text("Owner Last Name").boldText().blackColor(),
        CupertinoTextField(
          placeholder: "Doe",
        ),
        Text("Owner Mobile Number").boldText().blackColor(),
         mobileWidget,
        ElevatedButton(onPressed: () {}, child: Text("Update Profile"))
      ],
    );
  }
}
