import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/messages/MessageListItemView.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_MessagesListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageListener = Provider.of<Company_MessagesListViewModel>(context);
    Widget itemContainer = Container();
    if (messageListener.messageViewModelList == null) {
      itemContainer = Center(child: CircularProgressIndicator());
    } else {
      switch (messageListener.messageViewModelList.status) {
        case Status.LOADING:
          itemContainer = Center(child: CircularProgressIndicator());
          break;
        case Status.EMPTY:
          itemContainer = EmptyScreenResponse(message: "No New Message",);
          break;
        case Status.COMPLETED:
          itemContainer = ListView.builder(
            padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: messageListener.messageViewModelList.data.length,
              itemBuilder: (context, index) {
                return MessageListItemView(
                    messageModel:
                        messageListener.messageViewModelList.data[index]);
              });
          break;
        case Status.ERROR:
          itemContainer = ErrorScreenResponse();

          break;
      }
    }
    return itemContainer;
  }
}
