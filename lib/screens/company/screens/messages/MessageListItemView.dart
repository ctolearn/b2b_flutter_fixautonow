import 'dart:ffi';

import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_MessagesViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/ActionsListener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageListItemView extends StatelessWidget {
  Company_MessageViewModel messageModel;

  MessageListItemView({Key key, this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(messageModel.messages.timestamp);
    var amPm = DateFormat("a").format(date);
    return PhysicalModel(
        elevation: 6.0,
        shape: BoxShape.rectangle,
        shadowColor: Colors.black54,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
          onTap: (){
            Map<String,dynamic> mapData = new Map();
            mapData.putIfAbsent("to_user", () => messageModel.messages.to_user);
            mapData.putIfAbsent("booking_id", () => messageModel.messages.book_id);
            Navigator.of(context).pushNamed("/chat",arguments:mapData);
            Provider.of<ActionsListener>(context, listen: false)
                .closeToggle();
          },
            child: Card(
                elevation: 0,
                child: IntrinsicHeight(
                    child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(messageModel.messages.company,
                          style: TextStyle(fontSize: 13)),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: Text(messageModel.messages.chat_message,
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "REF # " + messageModel.messages.ref,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text.rich(TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                              child: FaIcon(
                            FontAwesomeIcons.calendarAlt,
                            size: 15,
                            color: Colors.grey,
                          )),
                          WidgetSpan(
                              child: SizedBox(
                            width: 5,
                          )),
                          TextSpan(
                              text:
                                  messageModel.messages.timestamp + " " + amPm,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey)),
                          WidgetSpan(
                              child: SizedBox(
                            width: 5,
                          )),
                        ],
                      ))
                    ],
                  ),
                )))));
  }
}
