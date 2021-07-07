import 'package:b2b_flutter_fixautonow/custom_dialog/CustomDialogViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/Custom_Dialog.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/Service.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyWorkTypeScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateServiceScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateUserScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CompanyServiceItemView extends StatelessWidget {
  Company_ServiceViewModel company_serviceViewModel;
  BuildContext buildContext;
  MessageCallBack messageCallBack;
  CompanyServiceItemView({this.company_serviceViewModel, this.messageCallBack});


  @override
  Widget build(BuildContext context) {
    Service serviceItem = company_serviceViewModel.service;
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
                              serviceItem.service_name,
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
                                                  CompanyAddUpdateServiceScreen(
                                                    id: serviceItem.service_id,
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
                                  GestureDetector(
                                      onTap: () {
                                        //CompanyWorkType_Screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompanyWorkTypeScreen(
                                                    service_id:
                                                        serviceItem.service_id,
                                                  )),
                                        );
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.cogs,
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
                                  "Service Category",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(serviceItem.service_category_name),
                                Text(
                                  "Open Time",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(serviceItem.service_start),
                                Text(
                                  "Close Time",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(serviceItem.service_end),
                                Text(
                                  "Approx. Duration",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(serviceItem.service_approximate),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(serviceItem.service_description),
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
          var serviceList = Provider.of<Company_ServiceListViewModel>(context);
          if (serviceList.crudResponse.crudType == "delete") {
            print(serviceList.crudResponse.status);
            switch (serviceList.crudResponse.status) {
              case Status.COMPLETED:
                closeDialog();
                messageCallBack.showMessage("AddOn item has been deleted");
                Provider.of<Company_ServiceListViewModel>(buildContext,
                        listen: false)
                    .fetchServiceList();
                break;
              case Status.ERROR:
                messageCallBack
                    .showMessage("Deleting Failed, Check your connection");
                Provider.of<Company_ServiceListViewModel>(buildContext,
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
                yesCallBack:
                    (serviceList.crudResponse.status == Status.LOADING &&
                            serviceList.crudResponse.crudType == "delete")
                        ? null
                        : deleteCallBack,
                noCallBack:
                    (serviceList.crudResponse.status == Status.LOADING &&
                            serviceList.crudResponse.crudType == "delete")
                        ? null
                        : closeDialog,
              ));
        });
  }

  void deleteCallBack() {
    Provider.of<Company_ServiceListViewModel>(buildContext, listen: false)
        .deleteService(company_serviceViewModel.service.service_id);
  }

  void closeDialog() {
    Navigator.of(buildContext).pop();
  }
}
