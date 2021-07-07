import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:b2b_flutter_fixautonow/model/Messages.dart';
import 'Company_MessagesViewModel.dart';

class Company_MessagesListViewModel extends ChangeNotifier {
  ApiResponse<List<Company_MessageViewModel>> messageViewModelList;

  void fetchMessageList() async {
    ApiResponse<List<Messages>> _response =
        await WebRepository().fetchMessages();
    switch (_response.status) {
      case Status.COMPLETED:
        if (_response.data.length == 0) {
          messageViewModelList = ApiResponse.empty();
        } else {
          messageViewModelList = ApiResponse.completed(_response.data
              .map((e) => Company_MessageViewModel(messages: e))
              .toList());
        }
        break;
      case Status.ERROR:
        messageViewModelList = ApiResponse.error();
        break;
    }
  }

  int messageCount() {
    return messageViewModelList != null
        ? messageViewModelList.data == null
            ? 0
            : messageViewModelList.data.length
        : 0;
  }
}
