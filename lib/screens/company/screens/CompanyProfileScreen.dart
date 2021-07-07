import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Profile.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ProfileListenerViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dropdownbutton_formfield_country.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/CountryDropdownListener.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/circular_image.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/ImagePickListener.dart';
class CompanyProfileScreen extends StatefulWidget {
  @override
  _CompanyProfile_ScreenState createState() => _CompanyProfile_ScreenState();
}

class _CompanyProfile_ScreenState extends State<CompanyProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_ProfileListenerViewModel>(context, listen: false)
        .fetchProfile();
    Provider.of<ImagePickListener>(context,listen: false).removeFile();

    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _ownerMobile = TextEditingController();
    _companyEmail = TextEditingController();
    _contact = TextEditingController();
    _description = TextEditingController();
    _state = TextEditingController();
    _city = TextEditingController();
    _addresss = TextEditingController();
  }

  TextEditingController _firstName,
      _lastName,
      _ownerMobile,
      _companyEmail,
      _contact,
      _description,
      _state,
      _city,
      _addresss;

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
      String isoCode, String dial, bool isValid) {
    print(isValid.toString());
  }

  String dropDownCountry = "United States of America";
  List<String> listCountry = ['+1'];
  String ownerNumber, ownerCode = '+1';
  String contactNumber, contactCode = '+1';


  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_ProfileListenerViewModel>(context, listen: false)
        .fetchProfile();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_ProfileListenerViewModel>(context, listen: false)
        .fetchProfile();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    var profileListener =
        Provider.of<Company_ProfileListenerViewModel>(context);
    Widget ownerMobileWidget, contactWidget, countryWidget, containerWidget;

    if (profileListener.apiResponse.data == null) {
      ownerCode = "+1";
      contactCode = "+1";
      ownerMobileWidget = InternationalPhoneInputController(
        controller: _ownerMobile,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: ownerCode,
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
      contactWidget = InternationalPhoneInputController(
        controller: _contact,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: ownerCode,
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
    } else {
      Profile profile = profileListener.apiResponse.data.profile;
      Provider.of<ImagePickListener>(context,listen: false).changeImage(imagePath: profile.company_photo);
      ownerCode = profile.owner_c_code;
      contactCode = profile.owner_c_code;
      _ownerMobile.text = profile.owner_mobile;
      _contact.text = profile.company_contact;
      _firstName.text = profile.owner_firstname;
      _lastName.text = profile.owner_lastname;
      _companyEmail.text = profile.company_email;
      _description.text = profile.company_description;
      _state.text = profile.company_state;
      _city.text = profile.company_city;
      _addresss.text = profile.company_address;
      dropDownCountry = profile.company_country;
      if (!listCountry.contains(ownerCode)) {
        ownerCode = "+1";
      }
      if (!listCountry.contains(contactCode)) {
        contactCode = "+1";
      }
      /** listener **/
      Provider.of<CountryDropdownListener>(context, listen: false)
          .changeCountry(country: dropDownCountry);
      ownerMobileWidget = InternationalPhoneInputController(
        controller: _ownerMobile,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: ownerCode,
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
      contactWidget = InternationalPhoneInputController(
        controller: _contact,
        onPhoneNumberChange: onPhoneNumberChange,
        initialSelection: ownerCode,
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

    containerWidget = ListView(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        Circular_Image(),
        SizedBox(
          height: 20,
        ),
        Text("Owner First Name").blackColor().boldText(),
        CircularTextField(
          descorationSize: DecorationSize.SMALL,
          isEnabled: true,
          controller: _firstName,
          hintText: "",
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Owner Last Name").blackColor().boldText(),
        CircularTextField(
          descorationSize: DecorationSize.SMALL,
          isEnabled: true,
          controller: _lastName,
          hintText: "",
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Owner Mobile Number").blackColor().boldText(),
        ownerMobileWidget,
        SizedBox(
          height: 10,
        ),
        Text("Company Email").blackColor().boldText(),
        CircularTextField(
          isEnabled: true,
          descorationSize: DecorationSize.SMALL,
          controller: _companyEmail,
          hintText: "",
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Contact").blackColor().boldText(),
        contactWidget,
        SizedBox(
          height: 10,
        ),
        Text("Description").blackColor().boldText(),
        CircularTextField(
          isEnabled: true,
          descorationSize: DecorationSize.SMALL,
          controller: _description,
          hintText: "",
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Text("State").blackColor().boldText(),
        CircularTextField(
          isEnabled: true,
          descorationSize: DecorationSize.SMALL,
          controller: _state,
          hintText: "",
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Text("City").blackColor().boldText(),
        CircularTextField(
          isEnabled: true,
          descorationSize: DecorationSize.SMALL,
          controller: _city,
          hintText: "",
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Country").blackColor().boldText(),
        DropDownButton_Formfield_Country(),
        SizedBox(
          height: 10,
        ),
        Text("Company Address").blackColor().boldText(),
        CircularTextField(
          descorationSize: DecorationSize.SMALL,
          isEnabled: true,
          controller: _city,
          hintText: "",
          color: Colors.white,
        ),
        ElevatedButton(onPressed: null, child: Text("Update Profile"))
      ],
    );
    switch (profileListener.apiResponse.status) {
      case Status.EMPTY:
        _refreshComplete();
        break;
      case Status.LOADING:
        break;
      case Status.ERROR:
        _refreshComplete();
        //containerWidget = ErrorScreenResponse();
        break;
      case Status.COMPLETED:
        _refreshComplete();

        break;
    }
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: _onLoading,
        child: containerWidget);

    return Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            Text("Owner First Name").blackColor().boldText(),
            CircularTextField(
              descorationSize: DecorationSize.SMALL,
              isEnabled: true,
              controller: _firstName,
              hintText: "",
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Owner Last Name").blackColor().boldText(),
            CircularTextField(
              descorationSize: DecorationSize.SMALL,
              isEnabled: true,
              controller: _lastName,
              hintText: "",
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Owner Mobile Number").blackColor().boldText(),
            ownerMobileWidget,
            SizedBox(
              height: 10,
            ),
            Text("Company Email").blackColor().boldText(),
            CircularTextField(
              isEnabled: true,
              descorationSize: DecorationSize.SMALL,
              controller: _companyEmail,
              hintText: "",
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Contact").blackColor().boldText(),
            contactWidget,
            SizedBox(
              height: 10,
            ),
            Text("Description").blackColor().boldText(),
            CircularTextField(
              isEnabled: true,
              descorationSize: DecorationSize.SMALL,
              controller: _description,
              hintText: "",
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text("State").blackColor().boldText(),
            CircularTextField(
              isEnabled: true,
              descorationSize: DecorationSize.SMALL,
              controller: _state,
              hintText: "",
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text("City").blackColor().boldText(),
            CircularTextField(
              isEnabled: true,
              descorationSize: DecorationSize.SMALL,
              controller: _city,
              hintText: "",
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Country").blackColor().boldText(),
            SizedBox(
              height: 10,
            ),
            Text("Company Address").blackColor().boldText(),
            CircularTextField(
              descorationSize: DecorationSize.SMALL,
              isEnabled: true,
              controller: _city,
              hintText: "",
              color: Colors.white,
            ),
            ElevatedButton(onPressed: null, child: Text("Update Profile"))
          ],
        ));
  }
}
/*

*/

/* List<String> listCountry = ['+1'];

  TextEditingController _firstName,
      _lastName,
      _ownerMobile,
      _companyEmail,
      _contact,
      _description,
      _state,
      _city,
      _addresss;
  String _country;

  //company
  String ownerNumber,ownerCode = '+1',ownerDialCode;
  void onPhoneNumberChangeOwner(String number, String internationalizedPhoneNumber, String isoCode,String dialCode) {
    Provider.of<Company_ProfileViewModel>(context, listen: false).setMobile(number, isoCode);
    print(number + " "+isoCode+" "+dialCode);

  }

  String companyNumber,companyCode = '+1',contactDialCode;
  void onPhoneNumberChangeContact(String number, String internationalizedPhoneNumber, String isoCode,String dialCode) {
    Provider.of<Company_ProfileViewModel>(context, listen: false).setCompanyNumber(number, isoCode);
    print(number + " "+isoCode+" "+dialCode);

  }

 @override
  Widget build(BuildContext context) {
    var profile = Provider.of<Company_ProfileViewModel>(context);
    if (profile.status == Status.COMPLETED) {
      Profile _profile = profile.company_profileModel.profile;
      _country = _profile.company_country;
      _firstName.text = _profile.owner_firstname;
      _lastName.text = _profile.owner_lastname;
      _ownerMobile.text = _profile.owner_mobile;
      _companyEmail.text = _profile.company_email;
      _contact.text = _profile.company_contact;
      _description.text = _profile.company_description;
      _state.text = _profile.company_state;
      _city.text = _profile.company_city;
      _addresss.text = _profile.company_address;
      companyCode =_profile.company_c_code;
      ownerCode = _profile.owner_c_code;
      if(!listCountry.contains(companyCode)){
        companyCode = "+1";
      }
      if(!listCountry.contains(ownerCode)){
        ownerCode = "+1";
      }


    }
    return ListView(padding: EdgeInsets.all(8), shrinkWrap: true, children: [
      SizedBox(
        height: 15,
      ),
      PhysicalModel(
          shape: BoxShape.rectangle,
          shadowColor: Colors.black54,
          color: Colors.black26,
          elevation: 6.0,
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                  width: 190.0,
                  height: 190.0,
                  child: Stack(children: [
                    Container(
                        width: 190.0,
                        child: ListView(shrinkWrap: true, children: [
                          PhysicalModel(
                              elevation: 6.0,
                              shape: BoxShape.circle,
                              shadowColor: Colors.black54,
                              color: Colors.grey,
                              child: Container(
                                  width: 190.0,
                                  height: 190.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              "https://i.imgur.com/BoN9kdC.png"))))),
                        ])),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          child: Text("Upload"),
                          onPressed: () {
                            profile.getFile();
                          },
                        ))
                  ])),
            ),
            SizedBox(
              height: 5,
            ),
            Text(profile.company_profileModel != null
                ? profile.company_profileModel.profile.company_name
                : ""),
            SizedBox(
              height: 15,
            ),
          ])),
      PhysicalModel(
          shape: BoxShape.rectangle,
          shadowColor: Colors.black54,
          color: Colors.white,
          elevation: 6.0,
          child: ListView(
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Profile_TextTitle(text: "Owner First Name"),
              Profile_Cupertino_TextField(
                placeholder: "John",
                controller: _firstName,
              ),
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "Owner Last Name"),
              Profile_Cupertino_TextField(
                placeholder: "Doe",
                controller: _lastName,
              ),
              //owner mobile
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "Owner Mobile"),
              InternationalPhoneInput(
                key:  Key("1"),
         */ /*       removeDuplicateCountries: ['CA'],
                  onPhoneNumberChange: onPhoneNumberChangeOwner,
                  initialPhoneNumber: ownerNumber,
                  initialSelection: ownerCode,
                  enabledCountries: listCountry,
                  textEditingController: _ownerMobile,*/ /*
                  isDefault: false,
              ),

              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "Company Email"),
              Profile_Cupertino_TextField(
                placeholder: "johndoe@gmail.com",
                controller: _companyEmail,
              ),
              //contact
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "Contact"),
              InternationalPhoneInput(
                key:  Key("2"),
              */ /*  removeDuplicateCountries: ['CA'],
                onPhoneNumberChange: onPhoneNumberChangeContact,
                initialPhoneNumber: companyNumber,
                initialSelection: companyCode,
                enabledCountries: listCountry,
                textEditingController: _contact,*/ /*
                isDefault: false,
              ),
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "Description"),
              Profile_Cupertino_TextField(
                placeholder: "Text Description",
                controller: _description,
              ),
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "State"),
              Profile_Cupertino_TextField(
                placeholder: "Text Description",
                controller: _state,
              ),
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "City"),
              Profile_Cupertino_TextField(
                placeholder: "Text Description",
                controller: _city,
              ),
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(
                text: "Country",
              ),
              DropDownCountry(
                onSelectParam: (country) {
                  print(country);
                  _country = country;
                },
              ),
              SizedBox(
                height: 5,
              ),
              Profile_TextTitle(text: "Company Address"),
              Profile_Cupertino_TextField(
                placeholder: "Company Address",
                controller: _addresss,
              ),
              ElevatedButton(
                  onPressed: profile.status == Status.COMPLETED ? () {
                    Profile _saveProfile = new Profile();
                    _saveProfile.owner_firstname = _firstName.text;
                    _saveProfile.owner_lastname = _lastName.text;
                    _saveProfile.company_email = _companyEmail.text;
                    _saveProfile.company_description =  _description.text;
                    _saveProfile.company_state = _state.text;
                    _saveProfile.company_city =  _city.text;
                    _saveProfile.company_country = _country;
                    _saveProfile.company_address = _addresss.text;
                    _saveProfile.company_contact = _contact.text;
                    _saveProfile.owner_mobile = _ownerMobile.text;

                    //already have at viewmodel
                    */ /*_saveProfile.company_contact = ",()=>company_contact);
                    _saveProfile.owner_mobile = _ownerMobile.text;
                    _saveProfile.owner_c_code = ",()=>owner_c_code);
                    _saveProfile.company_c_code = ",()=>company_c_code);


                     */ /*
                    profile.saveProfile(this,_saveProfile);

                  } : null,
                  child: Text("Update Profile"))
            ],
          ))
    ]);
  }

  @override
  void showMessage(String message) {
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
  }*/
