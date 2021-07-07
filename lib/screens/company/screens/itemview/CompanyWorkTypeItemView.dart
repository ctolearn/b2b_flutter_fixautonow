import 'package:b2b_flutter_fixautonow/custom_dialog/CustomDialogViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/Custom_Dialog.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_CompanyWorkTypeModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_WorkTypeListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CompanyWorkTypeItemView extends StatelessWidget {
  Company_CompanyWorkTypeModel company_companyWorkTypeModel;
  BuildContext buildContext;
  MessageCallBack messageCallBack;
  String service_id;
  CompanyWorkTypeItemView({this.company_companyWorkTypeModel,this.messageCallBack,this.service_id});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: IntrinsicHeight(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                        child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        company_companyWorkTypeModel.workType.type_name,
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
                                  /*         Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CompanyAddUpdateBranch_Screen(id: branchListModel
                                          .branchViewListModel[
                                      index]
                                          .branch
                                          .id,)),
                                    );*/
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
                                onTap: () {
                                  _showDialogDelete(context, "delete");
                                },
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
            Row(children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            company_companyWorkTypeModel
                                .workType.type_description,
                          ),
                          Text(
                            "Price",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "\$ " +
                                company_companyWorkTypeModel
                                    .workType.type_price,
                          )
                        ],
                      )))
            ]),
          ],
        )));
  }

  void _showDialogDelete(BuildContext context, String type) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          this.buildContext = context;
          var serviceList = Provider.of<Company_WorkTypeListModel>(context);
          if (serviceList.crudResponse.crudType == "delete") {
            print(serviceList.crudResponse.status);
            switch (serviceList.crudResponse.status) {
              case Status.COMPLETED:
                closeDialog();
                messageCallBack.showMessage("AddOn item has been deleted");
                Provider.of<Company_WorkTypeListModel>(buildContext,
                    listen: false)
                    .fetchCompanyWorkTypeList(service_id);
                break;
              case Status.ERROR:
                messageCallBack
                    .showMessage("Deleting Failed, Check your connection");
                Provider.of<Company_WorkTypeListModel>(buildContext,
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
    Provider.of<Company_WorkTypeListModel>(buildContext, listen: false)
        .deleteWorkType(company_companyWorkTypeModel.workType.work_id);
  }

  void closeDialog() {
    Navigator.of(buildContext).pop();
  }
}
