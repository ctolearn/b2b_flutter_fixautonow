
import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/EmployeeDashboard_Count.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';
import 'Employee_ViewModel.dart';

class Employee_ViewModelListener extends ChangeNotifier {
  Status status = Status.EMPTY;
  List<String> dashBoardCount = [];
  Employee_ViewModel employee_viewModel;
  ApiResponse<EmployeeDashboard_Count> employeeDashboard_Count = new ApiResponse();
  void fetchDashboard() async {
    employeeDashboard_Count = ApiResponse.loading();
    ApiResponse<EmployeeDashboard_Count> _apiResponse = await WebRepository().fetchEmployeeDashboard();
    notifyListeners();
    switch(_apiResponse.status){
      case Status.LOADING:
        employeeDashboard_Count = ApiResponse.loading();
        break;
      case Status.EMPTY:
        employeeDashboard_Count = ApiResponse.empty();
        break;
      case Status.ERROR:
        employeeDashboard_Count = ApiResponse.error();
        break;
      case Status.COMPLETED:

        dashBoardCount.add(_apiResponse.data.pending);
        dashBoardCount.add(_apiResponse.data.completed);
        employeeDashboard_Count = ApiResponse.completed(_apiResponse.data);

        break;

    }
    notifyListeners();
/*    status = Status.LOADING;
    EmployeeDashboard_Count employeeDashboard_Count =
        await WebService().fetchEmployeeDashboard();
    notifyListeners();
    employee_viewModel =
        Employee_ViewModel(employeeDashboard_Count: employeeDashboard_Count);
    dashBoardCount.add(employee_viewModel.employeeDashboard_Count.pending);
    dashBoardCount.add(employee_viewModel.employeeDashboard_Count.completed);

    status = Status.COMPLETED;
    notifyListeners();*/
  }
}
