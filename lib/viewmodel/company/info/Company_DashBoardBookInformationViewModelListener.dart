import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/AddOn.dart';
import 'package:b2b_flutter_fixautonow/model/BookReceive_Info.dart';
import 'package:b2b_flutter_fixautonow/model/Book_AddOn.dart';
import 'package:b2b_flutter_fixautonow/model/Book_WorkType.dart';
import 'package:b2b_flutter_fixautonow/model/Booking_Information.dart';
import 'package:b2b_flutter_fixautonow/model/Company_WorkType.dart';
import 'package:b2b_flutter_fixautonow/model/Invoice_Information.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookInformationViewModel.dart';

class Company_DashBoardBookInformationViewModelListener extends ChangeNotifier {
  ApiResponse<Company_BookInformationViewModel> fetchDashBoardItemInfo =
  ApiResponse();



  void fetchDashboardBookInformation(String booking_id) async {
    fetchDashBoardItemInfo = ApiResponse.loading();
    ApiResponse<BookReceive_Info> _apiResponse =
    await WebRepository().fetchDashboardBookInfo(booking_id);
    notifyListeners();
    switch (_apiResponse.status) {
      case Status.COMPLETED:
        fetchDashBoardItemInfo = ApiResponse.completed(
            Company_BookInformationViewModel.setBookReceiveInformation(
                _apiResponse.data));
        break;
      case Status.EMPTY:
        fetchDashBoardItemInfo = ApiResponse.empty();
        break;
      case Status.ERROR:
        fetchDashBoardItemInfo = ApiResponse.error();
        break;
    }
  }


}
