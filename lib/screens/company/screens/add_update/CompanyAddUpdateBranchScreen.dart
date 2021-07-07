import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/Branch.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_BranchListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/CountryDropdownListener.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dropdownbutton_formfield_country.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/CountryDropdownListener.dart';

class CompanyAddUpdateBranchScreen extends StatefulWidget {
  CompanyAddUpdateBranchScreen({this.id});

  String id;

  @override
  _CompanyAddUpdateBranch_ScreenState createState() =>
      _CompanyAddUpdateBranch_ScreenState();
}

class _CompanyAddUpdateBranch_ScreenState
    extends State<CompanyAddUpdateBranchScreen> implements MessageCallBack {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
        Duration.zero,
        () => Provider.of<Company_AddUpdate_BranchListenerViewModel>(context,
                listen: false)
            .resetStatus());
    if (widget.id != null) {
      Provider.of<Company_BranchListViewModel>(context,
              listen: false)
          .fetchBranch(id: widget.id);
    }
  }

  TextEditingController branchEmail_controller = TextEditingController();
  TextEditingController branchContact_controller = TextEditingController();
  TextEditingController branchDescription_controller = TextEditingController();
  TextEditingController branchState_controller = TextEditingController();
  TextEditingController branchCity_controller = TextEditingController();
  TextEditingController branchAdress_controller = TextEditingController();

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
      String isoCode, String dial, bool isValid) {
    print(isValid.toString());
  }

  void _updateBranch() {

    Provider.of<Company_AddUpdate_BranchListenerViewModel>(context,
        listen: false)
        .saveBranch();
/*    var branch = new Branch();
    branch.email = branchEmail_controller.text;
    branch.contact = branchContact_controller.text;
    branch.description = branchDescription_controller.text;
    branch.state = branchState_controller.text;
    branch.city = branchCity_controller.text;
    branch.country = _branchCountry;
    branch.address = branchAdress_controller.text;
    branch.c_code = branchCode;
    Provider.of<Company_BranchListViewModel>(context, listen: false)
        .saveBranch(id: widget.id, branch: branch, messageCallBack: this);*/
  }

  void _saveBranch() {
    /*  var branch = new Branch();
    branch.email = branchEmail_controller.text;
    branch.contact = branchContact_controller.text;
    branch.description = branchDescription_controller.text;
    branch.state = branchState_controller.text;
    branch.city = branchCity_controller.text;
    branch.country = _branchCountry;
    branch.address = branchAdress_controller.text;
    branch.c_code = branchCode;
    Provider.of<Company_BranchListViewModel>(context, listen: false)
        .saveBranch(id: widget.id, branch: branch, messageCallBack: this);
*/
  }

  String branchCode = '+1';
  List<String> listCountry = ['+1'];
  String dropDownCountry = "United States of America";
  TextEditingController name_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget branchContactWidget;
    var branchListener =
        Provider.of<Company_BranchListViewModel>(context);
    /*** update */
    if (widget.id != null) {
      branchCode = "+1";
      branchContactWidget = InternationalPhoneInputController(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        ),
        controller: branchContact_controller,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: branchCode,
        removeDuplicates: ["CA"],
        enabledCountries: ['+1'],
        showCountryCodes: true,
        showCountryFlags: true,
        withError: false,
      );
      if (branchListener.fetchResponse.data != null) {
        switch (branchListener.fetchResponse.status) {
          case Status.COMPLETED:
            Branch branchInfo = branchListener.fetchResponse.data;
            branchCode = branchInfo.c_code;
            dropDownCountry = branchInfo.country;
            branchCode = branchInfo.c_code;
            branchEmail_controller.text = branchInfo.email;
            branchContact_controller.text = branchInfo.contact;
            branchDescription_controller.text = branchInfo.description;
            branchState_controller.text = branchInfo.state;
            branchCity_controller.text = branchInfo.city;
            branchAdress_controller.text = branchInfo.address;
            if (!listCountry.contains(branchCode)) {
              branchCode = "+1";
            }
            Provider.of<CountryDropdownListener>(context,listen: false).changeCountry(country: dropDownCountry);
            branchContactWidget = InternationalPhoneInputController(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(8), // Added this
              ),
              controller: branchContact_controller,
              onPhoneNumberChange: onPhoneNumberChange,
              initialSelection: branchCode,
              removeDuplicates: ["CA"],
              enabledCountries: ['+1'],
              showCountryCodes: true,
              showCountryFlags: true,
              withError: false,
            );
            /*** listener */
            Provider.of<CountryDropdownListener>(context,listen:false).changeCountry(country: dropDownCountry);

            break;
          case Status.ERROR:
            //show error dialog to reload
            //saveCallBack = _updateAdDOn;
            break;
          case Status.EMPTY:
            //show error cant continue;
            //saveCallBack = _updateAdDOn;
            break;
          case Status.LOADING:
            // saveCallBack = null;
            break;
        }
      }

      /*** save */
    } else {
      branchCode = "+1";
      branchContactWidget = InternationalPhoneInputController(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        ),
        controller: branchContact_controller,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: branchCode,
        removeDuplicates: ["CA"],
        enabledCountries: ['+1'],
        showCountryCodes: true,
        showCountryFlags: true,
        withError: false,
      );
      Provider.of<CountryDropdownListener>(context,listen: false).changeCountry(country: dropDownCountry);
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.id == null ? "New Branch" : "Update Branch"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  Text("Branch Email").blackColor().boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: branchEmail_controller,
                    hintText: "",
                    color: Colors.white,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  //insert contact here
                  Text("Branch Contact").blackColor().boldText(),
                  branchContactWidget,
                  Text("Branch Description").blackColor().boldText(),
                  CircularTextField(
                      descorationSize: DecorationSize.SMALL,
                      isEnabled: true,
                      controller: branchDescription_controller,
                      hintText: "",
                      color: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  Text("State").blackColor().boldText(),
                  CircularTextField(
                      descorationSize: DecorationSize.SMALL,
                      isEnabled: true,
                      controller: branchState_controller,
                      hintText: "",
                      color: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  Text("City").blackColor().boldText(),
                  CircularTextField(
                      descorationSize: DecorationSize.SMALL,
                      isEnabled: true,
                      controller: branchCity_controller,
                      hintText: "",
                      color: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select Country").blackColor().boldText(),
                  DropDownButton_Formfield_Country(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Branch Address").blackColor().boldText(),
                  CircularTextField(
                      descorationSize: DecorationSize.SMALL,
                      isEnabled: true,
                      controller: branchAdress_controller,
                      hintText: "",
                      color: Colors.white),
                  SizedBox(
                    height: 10,
                  ),

                  Consumer<Company_AddUpdate_BranchListenerViewModel>(
                    builder: (context, value, child) {
                      VoidCallback transactCallback;
                      if(widget.id == null ){
                        transactCallback = (value.saveResponse.status == Status.LOADING
                            ? null
                            : _saveBranch);
                      }else{
                        if(branchListener.fetchResponse.status == Status.COMPLETED && value.saveResponse.status != Status.LOADING){
                          transactCallback = _updateBranch;
                        }else{
                          transactCallback = null;
                        }
                      }
                      return ElevatedButton(
                          onPressed: transactCallback,
                          child: Text(widget.id == null
                              ? "Save Branch"
                              : "Update Branch"));
                    },
                  )
                ])));

  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}
