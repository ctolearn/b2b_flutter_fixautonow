import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/AddOn.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_AddOnListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_AddOnListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';

class CompanyAddUpdateAddOnScreen extends StatefulWidget {
  CompanyAddUpdateAddOnScreen({this.id});

  String id;

  @override
  _CompanyAddUpdateAddOn_ScreenState createState() =>
      _CompanyAddUpdateAddOn_ScreenState();
}

class _CompanyAddUpdateAddOn_ScreenState
    extends State<CompanyAddUpdateAddOnScreen> implements MessageCallBack {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
        Duration.zero,
        () => Provider.of<Company_AddUpdate_AddOnListenerViewModel>(context,
                listen: false)
            .resetStatus());
    if (widget.id != null) {
      Provider.of<Company_AddOnListViewModel>(context, listen: false)
          .fetchAddOn(id: widget.id);
    }
  }

  TextEditingController name_controller = TextEditingController();
  TextEditingController description_controller = TextEditingController();
  TextEditingController price_controller = TextEditingController();

  void _updateAdDOn() {
    var addOnSave = new AddOn();
    addOnSave.addon_description = description_controller.text;
    addOnSave.addon_price = price_controller.text;
    addOnSave.addon_name = name_controller.text;
    addOnSave.addon_id = widget.id;
    Provider.of<Company_AddUpdate_AddOnListenerViewModel>(context,
            listen: false)
        .saveAddOn(addOn: addOnSave, messageCallBack: this);
  }

  void _saveAddOn() {
    var addOnSave = new AddOn();
    addOnSave.addon_description = description_controller.text;
    addOnSave.addon_price = price_controller.text;
    addOnSave.addon_name = name_controller.text;
    Provider.of<Company_AddUpdate_AddOnListenerViewModel>(context,
            listen: false)
        .saveAddOn(addOn: addOnSave, messageCallBack: this);
  }

  @override
  Widget build(BuildContext context) {
    var addOnListener = Provider.of<Company_AddOnListViewModel>(context);
    /*** update */
    if (widget.id != null) {
      if (addOnListener.fetchResponse.status != null) {
        switch (addOnListener.fetchResponse.status) {
          case Status.COMPLETED:
            AddOn addOnInfo = addOnListener.fetchResponse.data;
            name_controller.text = addOnInfo.addon_name;
            description_controller.text = addOnInfo.addon_description;
            price_controller.text = addOnInfo.addon_price;

            /*** update listener */
/*            if (addOnListener.saveResponse.status != null) {
              switch (addOnListener.saveResponse.status) {
                case Status.COMPLETED:
                  AddOn addOnInfo = addOnListener.fetchResponse.data;
                  name_controller.text = addOnInfo.addon_name;
                  description_controller.text = addOnInfo.addon_description;
                  price_controller.text = addOnInfo.addon_price;
                  break;
                case Status.ERROR:
                  saveCallBack = _saveAddOn;
                  break;
                case Status.EMPTY:
                  saveCallBack = _saveAddOn;
                  break;
                case Status.LOADING:
                  saveCallBack = null;
                  break;
              }
            }*/

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
            break;
        }
      }
      /*** save */
    } else {
      /*** save listener */
      /*     print(addOnListener.saveResponse.status);
      if (addOnListener.saveResponse.status != null) {
        switch (addOnListener.saveResponse.status) {
          case Status.COMPLETED:
            AddOn addOnInfo = addOnListener.fetchResponse.data;
            name_controller.text = addOnInfo.addon_name;
            description_controller.text = addOnInfo.addon_description;
            price_controller.text = addOnInfo.addon_price;
            break;
          case Status.ERROR:
            saveCallBack = _saveAddOn;
            break;
          case Status.EMPTY:
            saveCallBack = _saveAddOn;
            break;
          case Status.LOADING:
            saveCallBack = null;
            break;
        }
      }*/
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.id == null ? "New Add On" : "Update Add On"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  Text("AddOn Name").blackColor().boldText(),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: true,
                    controller: name_controller,
                    hintText: "Name",
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("AddOn Description").blackColor().boldText(),
                  CircularTextField(
                      descorationSize: DecorationSize.SMALL,
                      isEnabled: true,
                      controller: description_controller,
                      hintText: "Description",
                      color: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  Text("AddOn Price").blackColor().boldText(),
                  CircularTextField(
                      descorationSize: DecorationSize.SMALL,
                      isEnabled: true,
                      controller: price_controller,
                      hintText: "Price",
                      color: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<Company_AddUpdate_AddOnListenerViewModel>(
                    builder: (context, value, child) {
                      VoidCallback transactCallback;
                      if(widget.id == null ){
                        transactCallback = (value.saveResponse.status == Status.LOADING
                            ? null
                            : _saveAddOn);
                      }else{
                        if(addOnListener.fetchResponse.status == Status.COMPLETED && value.saveResponse.status != Status.LOADING){
                          transactCallback = _updateAdDOn;
                        }else{
                          transactCallback = null;
                        }
                      }
                      return ElevatedButton(
                          onPressed: transactCallback,
                          child: Text(widget.id == null
                              ? "Save Add On"
                              : "Update Add On"));
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
