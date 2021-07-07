import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/DashBoard_Book.dart';
import 'package:b2b_flutter_fixautonow/model/DashboardCount.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';
import 'Company_DashBoardViewModel.dart';

class Company_DashBoardListModel extends ChangeNotifier {
  ApiResponse<List<Company_DashBoardModel>> companyDashboardItemList =
      ApiResponse();
  ApiResponse<List<Company_DashBoardModel>> companyViewMoreItemList =
      ApiResponse();
  ApiResponse<List<String>> dashBoardCount = ApiResponse();

  void fetchDashBoard() async {
    companyDashboardItemList = ApiResponse.loading();
    ApiResponse<List<DashBoardBook>> _dashboardBookListResponse =
        await WebRepository().fetchDashboardItems();
    notifyListeners();
    switch (_dashboardBookListResponse.status) {
      case Status.COMPLETED:
        ApiResponse<DashboardCount> _dashboardCount =
            await WebRepository().fetchDashboardCount();
        break;
      case Status.EMPTY:
        ApiResponse<DashboardCount> _dashboardCount =
            await WebRepository().fetchDashboardCount();
        break;
      case Status.ERROR:
        break;
    }
    notifyListeners();
    /*   status = Status.LOADING;
    List<DashBoardBook> dashboardBookList =
        await WebService().fetchDashboardItems();
    notifyListeners();
    this.companyDashboardItemList = dashboardBookList
        .map((item) => Company_DashBoardModel(dashBoardBook: item))
        .toList();
    if (companyDashboardItemList.isEmpty) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }*/
  }

  void fetchViewMoreList() async {
    companyViewMoreItemList = ApiResponse.loading();
    ApiResponse<List<DashBoardBook>> _dashboardBookListResponse =
        await WebRepository().fetchDashboardItems();
    notifyListeners();
    switch (_dashboardBookListResponse.status) {
      case Status.COMPLETED:
        companyViewMoreItemList = ApiResponse.completed(
            _dashboardBookListResponse.data
                .map((e) => Company_DashBoardModel(dashBoardBook: e))
                .toList());
        break;
      case Status.ERROR:
        companyViewMoreItemList = ApiResponse.error();
        break;
      case Status.EMPTY:
        companyViewMoreItemList = ApiResponse.empty();
        break;
    }
    notifyListeners();
  }

  void fetchDashBoardCount() async {
    dashBoardCount = ApiResponse.loading();
    companyDashboardItemList = ApiResponse.loading();
    ApiResponse<DashboardCount> _dashboardCount =
        await WebRepository().fetchDashboardCount();
    notifyListeners();
    switch (_dashboardCount.status) {
      case Status.COMPLETED:
      case Status.EMPTY:
        var listDashItem = <String>[];
        listDashItem.add(_dashboardCount.data.branches);
        listDashItem.add(_dashboardCount.data.users);
        listDashItem.add(_dashboardCount.data.services);
        listDashItem.add(_dashboardCount.data.add_ons);
        listDashItem.add(_dashboardCount.data.received_booking);
        listDashItem.add(_dashboardCount.data.sent_booking);
        dashBoardCount = ApiResponse.completed(listDashItem);
        companyDashboardItemList = ApiResponse.loading();
        ApiResponse<List<DashBoardBook>> _dashboardBookListResponse =
            await WebRepository().fetchDashboardItems();
        notifyListeners();
        print(_dashboardBookListResponse.status);
        switch (_dashboardBookListResponse.status) {
          case Status.COMPLETED:
            companyDashboardItemList = ApiResponse.completed(
                _dashboardBookListResponse.data
                    .map((e) => Company_DashBoardModel(dashBoardBook: e))
                    .toList());
            break;
          case Status.ERROR:
            companyDashboardItemList = ApiResponse.error();
            break;
          case Status.EMPTY:
            companyDashboardItemList = ApiResponse.empty();
            break;
        }
        break;
      case Status.ERROR:
        break;
    }
    notifyListeners();
    /*  status_count = Status.LOADING;
    DashboardCount dashboardCount = await WebService().fetchDashboardCount();
    notifyListeners();
    status_count = Status.COMPLETED;
    this.dashBoardCount.add(dashboardCount.branches);
    this.dashBoardCount.add(dashboardCount.users);
    this.dashBoardCount.add(dashboardCount.services);
    this.dashBoardCount.add(dashboardCount.add_ons);
    this.dashBoardCount.add(dashboardCount.received_booking);
    this.dashBoardCount.add(dashboardCount.sent_booking);
    notifyListeners();*/
  }

  int notificationCount(){

    return companyDashboardItemList.data != null? companyDashboardItemList.data.where((element) => element.dashBoardBook.status == "1" &&
        element.dashBoardBook.is_you == "y" || element.dashBoardBook.status == "1" &&
        element.dashBoardBook.is_you == "n").length : 0;
  }
/*  DashBoardBook dashBoardBook;
  CompanyMainScreen_DashBoardModel({this.dashBoardBook});*/

}
