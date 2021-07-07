import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/DashBoard_Book.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';
import '../Company_DashBoardViewModel.dart';


class Company_ViewMoreListViewModel extends ChangeNotifier {

  ApiResponse<List<Company_DashBoardModel>> companyViewMoreItemList =
      ApiResponse();



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



}
