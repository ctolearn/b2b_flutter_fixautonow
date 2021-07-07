import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Chat.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ChatViewModelList.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';

class ChatScreen extends StatefulWidget {
  Map<String, dynamic> mapData;

  ChatScreen({Key key, this.mapData}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_ChatViewModelList>(context, listen: false)
        .fetchChatList(booking_id: widget.mapData["booking_id"]);
    print("booking_id is " +widget.mapData["booking_id"]);


  }

  @override
  Widget build(BuildContext context) {
    var chatListModel = Provider.of<Company_ChatViewModelList>(context);
    Widget itemContainer = Container();
    switch (chatListModel.company_chatViewModelList.status) {
      case Status.LOADING:
        break;
      case Status.ERROR:
        itemContainer = ErrorScreenResponse();
        break;
      case Status.EMPTY:
        itemContainer = EmptyScreenResponse();
        break;
      case Status.COMPLETED:
        itemContainer = ListView.separated(
          itemCount: chatListModel.company_chatViewModelList.data.length,
          itemBuilder: (context, index) {
            Chat chat =
                chatListModel.company_chatViewModelList.data[index].chat;
            return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat.company),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      child: Text(chat.ref,
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                      margin: EdgeInsets.only(right: 5),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(chat.chat_message,
                        style: TextStyle(
                          fontWeight: (chat.is_bold
                              ? FontWeight.bold
                              : FontWeight.normal),
                        )),
                  ],
                ));

            Card(
                child: Text(chatListModel
                    .company_chatViewModelList.data[index].chat.chat_message));
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
        break;
    }
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Chat"),),
      body: itemContainer,
    );
  }
}
