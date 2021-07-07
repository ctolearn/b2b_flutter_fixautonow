import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_ViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_ViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';

import 'itemview/EmployeePendingItem.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  @override
  _EmployeeDashboard_ScreenState createState() =>
      _EmployeeDashboard_ScreenState();
}

class _EmployeeDashboard_ScreenState extends State<EmployeeDashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Employee_ViewModelListener>(context, listen: false)
        .fetchDashboard();
  }

  @override
  Widget build(BuildContext context) {
    var employeeDashboardViewModel =
        Provider.of<Employee_ViewModelListener>(context);

    List<String> dashItem = [
      "Pending",
      "Completed",
    ];
    Widget widget;
    Widget gridView = GridView.builder(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.

      physics: NeverScrollableScrollPhysics(),
      // to disable GridView's scrolling
      shrinkWrap: true,
      // You won't see infinite size error
      itemCount: dashItem.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: 2, height: 100),
      itemBuilder: (c, index) {
        return Card(
            child: Column(
          children: [
            Container(
                color: Colors.grey,
                width: double.maxFinite,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      dashItem[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white70),
                    ))),
            Expanded(
                child: Center(
                    child: employeeDashboardViewModel
                                .employeeDashboard_Count.status ==
                            Status.LOADING
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            employeeDashboardViewModel.dashBoardCount[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )))
          ],
        ));
      },
    );
    if (employeeDashboardViewModel.employee_viewModel == null) {
    } else {
      // Generate 100 widgets that display their index in the List.

      /*   children: List.generate(dashItem.length, (index) {
        return Card(child:Padding(padding:EdgeInsets.all(5),child:Column(
          children: [
            Text(dashItem[index],style: TextStyle(fontWeight: FontWeight.bold),),
            Expanded(child:
            Center(child: CircularProgressIndicator(),))

          ],
        )));
      }),*/

      switch (employeeDashboardViewModel.employeeDashboard_Count.status) {
        default:
          widget = Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
          break;
      }
    }
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            gridView,
            Card(
                child: Column(
              children: [
                Container(
                    color: Colors.grey,
                    width: double.maxFinite,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Task Today ( " +
                              DateFormat('yyyy-MM-dd').format(DateTime.now()) +
                              " )",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ))),
                employeeDashboardViewModel.employeeDashboard_Count.status ==
                        Status.LOADING
                    ? CircularProgressIndicator()
                    : (employeeDashboardViewModel
                                .employeeDashboard_Count.data.jobList.length ==
                            0
                        ? Text("No Task Today")
                        : ListView.builder(
                            itemCount: employeeDashboardViewModel
                                .employeeDashboard_Count.data.jobList.length,
                            itemBuilder: (context, index) {
                              return EmployeePendingItem(
                                employee_jobViewModel: Employee_JobViewModel(
                                    job: employeeDashboardViewModel
                                        .employeeDashboard_Count
                                        .data
                                        .jobList[index]),
                              );
                            }))
              ],
            ))
          ],
        ));
  }
}
