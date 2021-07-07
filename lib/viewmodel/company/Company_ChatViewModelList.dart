import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';
import 'Company_ChatViewModel.dart';
import 'package:b2b_flutter_fixautonow/model/Chat.dart';

class Company_ChatViewModelList extends ChangeNotifier {
  ApiResponse<List<Company_ChatViewModel>> company_chatViewModelList = new ApiResponse();

  void fetchChatList({String booking_id}) async {
    company_chatViewModelList = ApiResponse.loading();
    ApiResponse<List<Chat>> _response = await WebRepository().fetchChats(booking_id: booking_id);
    notifyListeners();
    switch (_response.status) {
      case Status.COMPLETED:
        company_chatViewModelList = _response.data.length == 0
            ? ApiResponse.empty()

            : ApiResponse.completed(_response.data
                .map((e) => Company_ChatViewModel(chat: e))
                .toList());
        break;
      case Status.ERROR:
        company_chatViewModelList = _response.data == null
            ? ApiResponse.empty()
            : _response.data
                .map((e) => Company_ChatViewModel(chat: e))
                .toList();
        break;
    }
    notifyListeners();
  }
}
