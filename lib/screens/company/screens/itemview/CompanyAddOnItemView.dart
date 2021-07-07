import 'package:b2b_flutter_fixautonow/custom_dialog/CustomDialogViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/Custom_Dialog.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/User.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateAddOnScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateUserScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_AddOnListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_AddOnViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CompanyAddOnItemView extends StatelessWidget {
  Company_AddOnViewModel company_addOnViewModel;
  BuildContext buildContext;
  MessageCallBack messageCallBack;

  CompanyAddOnItemView({this.company_addOnViewModel, this.messageCallBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: PhysicalModel(
            elevation: 6.0,
            shape: BoxShape.rectangle,
            shadowColor: Colors.black54,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            child: Card(
                elevation: 0,
                child: IntrinsicHeight(
                    child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                              child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              company_addOnViewModel.addOn.addon_name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(25.0),
                              )),
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompanyAddUpdateAddOnScreen(
                                                    id: company_addOnViewModel
                                                        .addOn.addon_id,
                                                  )),
                                        );
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.edit,
                                        size: 15,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                      onTap: () => _showDialogDelete(
                                            context,
                                            "delete",
                                          ),
                                      child: FaIcon(
                                        FontAwesomeIcons.trash,
                                        size: 15,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ))),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AddOn Price",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text('\$ ' +
                                    company_addOnViewModel.addOn.addon_price),
                                Text(
                                  "AddOn Description",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_addOnViewModel
                                    .addOn.addon_description),
                              ],
                            ),
                          )),
                    ],
                  ),
                ])))));
  }

  void _showDialogDelete(BuildContext context, String type) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          this.buildContext = context;
          var addOnList = Provider.of<Company_AddOnListViewModel>(context);
          if (addOnList.crudResponse.crudType == "delete") {
            print(addOnList.crudResponse.status);
            switch (addOnList.crudResponse.status) {
              case Status.COMPLETED:
                closeDialog();
                messageCallBack.showMessage("AddOn item has been deleted");
                Provider.of<Company_AddOnListViewModel>(buildContext,
                        listen: false)
                    .fetchAddOnList();
                break;
              case Status.ERROR:
                messageCallBack
                    .showMessage("Deleting Failed, Check your connection");
                Provider.of<Company_AddOnListViewModel>(buildContext,
                        listen: false)
                    .resetCrud();
                break;
            }
          }
          var dialogModel = CustomDialogViewModel(type: type);
          return new WillPopScope(
              onWillPop: () async => false,
              child: CustomDialog(
                title: dialogModel.getTitle(),
                message: dialogModel.getMessage(),
                yesCallBack: (addOnList.crudResponse.status == Status.LOADING &&
                        addOnList.crudResponse.crudType == "delete")
                    ? null
                    : deleteCallBack,
                noCallBack: (addOnList.crudResponse.status == Status.LOADING &&
                        addOnList.crudResponse.crudType == "delete")
                    ? null
                    : closeDialog,
              ));
        });
  }

  void deleteCallBack() {
    Provider.of<Company_AddOnListViewModel>(buildContext, listen: false)
        .deleteOutlier(company_addOnViewModel.addOn.addon_id);
  }

  void closeDialog() {
    Navigator.of(buildContext).pop();
  }
}
