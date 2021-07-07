import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_UserListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_UsersListenerViewModel.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dropdownbutton_formfield_accounttype.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/AccountTypeDropdownListener.dart';

class CompanyAddUpdateBranchUserScreen extends StatefulWidget {
  CompanyAddUpdateBranchUserScreen({this.company_id,this.user_id});

  String company_id,user_id;

  @override
  _CompanyAddUpdateBranchUserScreenState createState() =>
      _CompanyAddUpdateBranchUserScreenState();
}

class _CompanyAddUpdateBranchUserScreenState
    extends State<CompanyAddUpdateBranchUserScreen> implements MessageCallBack {

  final key = new GlobalKey<DropDownButton_Formfield_AccountTypeState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user_id != null) {
      Provider.of<Company_UsersListViewModel>(context,
              listen: false)
          .fetchUser(id: widget.user_id);
    }else{
      firstName_controller.clear();
      lastName_controller.clear();
      mobile_controller.clear();
      email_controller.clear();

    }
  }

  List<String> listCountry = ['+1'];
  String _accountType = 'Admin';
  TextEditingController firstName_controller = TextEditingController();
  TextEditingController lastName_controller = TextEditingController();
  TextEditingController mobile_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  String mobileCode = '+1';



  void _updateUser() {

    Provider.of<Company_AddUpdate_UsersListenerViewModel>(context, listen: false).saveUser();
/*    var user = new User();
    user.firstname = firstName_controller.text;
    user.lastname = lastName_controller.text;
    user.email = lastName_controller.text;
    user.type = _accountType;
    user.mobile = mobile_controller.text;
    Provider.of<Company_UsersListViewModel>(context, listen: false).saveUser(
        id: widget.id,
        user: user,
        password: password_controller.text,
        messageCallBack: this);*/
  }

  void _saveUser() {
    Provider.of<Company_AddUpdate_UsersListenerViewModel>(context, listen: false).saveUser();
/*    var user = new User();
    user.firstname = firstName_controller.text;
    user.lastname = lastName_controller.text;
    user.email = lastName_controller.text;
    user.type = _accountType;
    user.mobile = mobile_controller.text;
    Provider.of<Company_UsersListViewModel>(context, listen: false).saveUser(
        id: widget.id,
        user: user,
        password: password_controller.text,
        messageCallBack: this);*/
  }

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
      String isoCode, String dial, bool isValid) {
    print(isValid.toString());
  }

  VoidCallback saveCallBack = null;

  @override
  Widget build(BuildContext context) {
    var userListener =
        Provider.of<Company_UsersListViewModel>(context);

    Widget mobileNumberWidget;
    if (widget.user_id != null) {
      mobileNumberWidget = InternationalPhoneInputController(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        ),
        controller: mobile_controller,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: mobileCode,
        removeDuplicates: ["CA"],
        enabledCountries: ['+1'],
        showCountryCodes: true,
        showCountryFlags: true,
        withError: false,
      );
      if (userListener.fetchResponse.data != null) {
        switch (userListener.fetchResponse.status) {
          case Status.COMPLETED:
            User user = userListener.fetchResponse.data;
            _accountType = user.type;
            mobileCode = user.c_code;
            firstName_controller.text = user.firstname;
            lastName_controller.text = user.lastname;
            mobile_controller.text = user.mobile;
            if (!listCountry.contains(mobileCode)) {
              mobileCode = "+1";
            }
            mobileNumberWidget = InternationalPhoneInputController(
              controller: mobile_controller,
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

            /*** update listener */
            Provider.of<AccountTypeDropdownListener>(context,listen: false).changeAccountType(account:  _accountType);
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
            saveCallBack = null;
            break;
        }
      }
    } else {
      mobileNumberWidget = InternationalPhoneInputController(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), // Added this
        ),
        controller: mobile_controller,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: mobileCode,
        removeDuplicates: ["CA"],
        enabledCountries: ['+1'],
        showCountryCodes: true,
        showCountryFlags: true,
        withError: false,
      );


    }

    /*if (userModel.status_info == Status.COMPLETED) {
      User user = userModel.user;
      _accountType = user.type;
      userCode = user.c_code;
      firstName_controller.text = user.firstname;
      lastName_controller.text = user.lastname;
      mobile_controller.text = user.mobile;
      email_controller.text = user.email;
      userNumber = user.mobile;
      //password_controller.text =  ;
      print(_accountType);
    } else {
      firstName_controller.clear();
      lastName_controller.clear();
      mobile_controller.clear();
      email_controller.clear();
    }*/

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.user_id == null ? "New User" : "Update User"),
        ),
        body:
            ListView(padding: EdgeInsets.all(16), shrinkWrap: true, children: [
          Text("Account Type").blackColor().boldText(),
          DropDownButton_Formfield_AccountType(key:key,),
          Text("First Name").blackColor().boldText(),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: true,
            controller: firstName_controller,
            hintText: "",
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Last Name").blackColor().boldText(),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: true,
            controller: lastName_controller,
            hintText: "",
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),

          //insert mobile here
          Text("Mobile Number").blackColor().boldText(),
          mobileNumberWidget,
          widget.user_id != null
              ? Container()
              : Column(children: [
                  Text("Email").blackColor().boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: email_controller,
                    hintText: "",
                    color: Colors.white,
                  )
                ]),
          SizedBox(
            height: 10,
          ),
          widget.user_id != null
              ? Container()
              : Column(children: [
                  Text("Password").blackColor().boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: password_controller,
                    hintText: "",
                    color: Colors.white,
                  )
                ]),
          SizedBox(
            height: 10,
          ),

              Consumer<Company_AddUpdate_UsersListenerViewModel>(
                builder: (context, value, child) {

                  VoidCallback transactCallback;
                  if(widget.user_id == null ){
                    transactCallback = (value.saveResponse.status == Status.LOADING
                        ? null
                        : _updateUser);
                  }else{
                    if(userListener.fetchResponse.status == Status.COMPLETED && value.saveResponse.status != Status.LOADING){
                      transactCallback = _updateUser;
                    }else{
                      transactCallback = null;
                    }
                  }

                  return ElevatedButton(
                      onPressed: transactCallback,
                      child: Text(widget.user_id == null
                          ? "Save User"
                          : "Update User"));
                },
              )
        ]));


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
