import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModelList.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:b2b_flutter_fixautonow/screens/employee/screens/itemview/EmployeePendingItem.dart';

class EmployeePendingScreen extends StatefulWidget {
  @override
  _EmployeePending_ScreenState createState() => _EmployeePending_ScreenState();
}

class _EmployeePending_ScreenState extends State<EmployeePendingScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Employee_JobViewModelList>(context, listen: false)
        .fetchJob("pending");
  }

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Employee_JobViewModelList>(context, listen: false)
        .fetchJob("pending");
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Employee_JobViewModelList>(context, listen: false)
        .fetchJob("pending");
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    var employeeJobViewModelList =
        Provider.of<Employee_JobViewModelList>(context);
    Widget widget = Container();

    switch (employeeJobViewModelList.employeeJobViewModelList.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        _refreshComplete();
        widget = ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount:
                employeeJobViewModelList.employeeJobViewModelList.data.length,
            itemBuilder: (context, index) {
              Employee_JobViewModel employee_jobViewModel =
                  employeeJobViewModelList.employeeJobViewModelList.data[index];
              return EmployeePendingItem(
                employee_jobViewModel: employee_jobViewModel,
              );
            });
        break;
      case Status.EMPTY:
        _refreshComplete();
        widget = EmptyScreenResponse();
        break;
      case Status.ERROR:
        _refreshComplete();
        widget = ErrorScreenResponse();
        break;
    }
    return Scaffold(
        body: SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: MaterialClassicHeader(),
      controller: _refreshController,
      onRefresh: onRefresh,
      onLoading: _onLoading,
      child: widget,
    ));
  }
}
