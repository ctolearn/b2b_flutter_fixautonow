import 'dart:async';

import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ProfileListenerViewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';

class ValidatorScreen extends StatefulWidget {
  const ValidatorScreen({Key key}) : super(key: key);

  @override
  _ValidatorScreenState createState() => _ValidatorScreenState();
}

class PhoneNumber {
  String code, dialCode, number, internationalize;

  PhoneNumber({this.code, this.dialCode, this.number, this.internationalize});
}

class _ValidatorScreenState extends State<ValidatorScreen> {
  String phoneNumber = "";
  String phoneIsoCode = "+1";
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
      String isoCode, String dial, bool isValid) {
    print(isValid.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Company_ProfileListenerViewModel>(context, listen: false)
        .fetchProfile();
  }

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profileListener =
        Provider.of<Company_ProfileListenerViewModel>(context);
    controller.text = profileListener.apiResponse.data != null
        ? profileListener.apiResponse.data.profile.owner_mobile
        : "12312312";
    return Scaffold(
        body: ListView(shrinkWrap: true, children: [
      Container(),

      InternationalPhoneInputController(
        controller: controller,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: '+1',
        removeDuplicates: ["CA"],
        enabledCountries: ['+1'],
        showCountryCodes: true,
        showCountryFlags: true,
        withError: false,
      )
/*
          ValueListenableBuilder<ValueA>(
              builder: (context, value, child){
                return InternationalPhoneInput(
                decoration:
                InputDecoration.collapsed(hintText: '(123) 123-1234'),
                onPhoneNumberChange: onPhoneNumberChange,
                initialPhoneNumber: '1',
                initialSelection: '+1',
                enabledCountries: ['+233', '+1'],
                showCountryCodes: true,
                showCountryFlags: true,
                isDefault: false,);
        },
            valueListenable: _counter,),*/
      /*InternationalPhoneInput(
        onPhoneNumberChange: onPhoneNumberChange,
        initialPhoneNumber: phoneNumber,
        initialSelection: phoneIsoCode,
        enabledCountries: ['+233', '+1'],
        labelText: "Phone Number",
      )*/
    ]));
  }
}
