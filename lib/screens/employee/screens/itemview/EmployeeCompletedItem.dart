import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class EmployeeCompletedItem extends StatelessWidget {
  Employee_JobViewModel employee_jobViewModel;
  EmployeeCompletedItem({Key key,this.employee_jobViewModel}) : super(key: key);
  void moveToReceiveViewInformation(BuildContext context) {
    Navigator.pushNamed(context, "/receiveview",arguments: employee_jobViewModel.job.id);
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
                                      SizedBox(
                                        width: 15,
                                      ),
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
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
}
