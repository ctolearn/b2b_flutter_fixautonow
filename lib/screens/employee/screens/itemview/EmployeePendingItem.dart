import 'package:b2b_flutter_fixautonow/custom_dialog/CustomDialogViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/Custom_Dialog.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModelList.dart';
import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EmployeePendingItem extends StatelessWidget {
  Employee_JobViewModel employee_jobViewModel;
  BuildContext buildContext;
  MessageCallBack messageCallBack;
  EmployeePendingItem({Key key, this.employee_jobViewModel}) : super(key: key);

  void moveToReceiveViewInformation(BuildContext context) {
    Navigator.pushNamed(context, "/receiveview",
        arguments: employee_jobViewModel.job.id);
  }

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
                                  SizedBox(width: 30),
                                  ConstrainedBox(
                                      constraints:
                                          BoxConstraints.tightFor(height: 20),
                                      child: ElevatedButton(
                                        onPressed: (){
                                          _showDialogComplete(context,"complete");
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18.0),
                                                )
                                            )
                                        ),
                                        child: Text(
                                          "Complete",
                                          style: TextStyle(fontSize: 10,color: Colors.blue),
                                        ),
                                      )),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                      onTap: () {
                                        moveToReceiveViewInformation(context);
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.infoCircle,
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
                                  "Reference #",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(employee_jobViewModel.job.ref),
                                Text(
                                  "Company Name",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(employee_jobViewModel.job.company_name),
                                Text(
                                  "Company Address",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(employee_jobViewModel.job.address),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(employee_jobViewModel.job.date)
                                          ]),
                                    ),
                                    Expanded(
                                      child: Column(children: [
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(employee_jobViewModel.job.time)
                                      ]),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ])))));
  }



  void _showDialogComplete(BuildContext context, String type) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          this.buildContext = context;
          var jobList = Provider.of<Employee_JobViewModelList>(context);
          if (jobList.crudResponse.crudType == "delete") {
            switch (jobList.crudResponse.status) {
              case Status.COMPLETED:
                closeDialog();
                messageCallBack.showMessage("Branch item has been deleted");
                Provider.of<Employee_JobViewModelList>(buildContext,
                    listen: false)
                    .fetchJob("pending");
                break;
              case Status.ERROR:
                messageCallBack
                    .showMessage("Deleting Failed, Check your connection");
                Provider.of<Employee_JobViewModelList>(buildContext,
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
                yesCallBack: (jobList.crudResponse.status == Status.LOADING &&
                    jobList.crudResponse.crudType == "complete")
                    ? null
                    : deleteCallBack,
                noCallBack: (jobList.crudResponse.status == Status.LOADING &&
                    jobList.crudResponse.crudType == "complete")
                    ? null
                    : closeDialog,
              ));
        });
  }

  void deleteCallBack() {
    Provider.of<Employee_JobViewModelList>(buildContext)
        .completeJob(employee_jobViewModel.job.id);
  }

  void closeDialog() {
    Navigator.of(buildContext).pop();
  }
}
