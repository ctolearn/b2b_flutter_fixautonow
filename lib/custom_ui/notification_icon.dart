import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notification_Icon extends StatelessWidget {
  FaIcon faIcon;
  VoidCallback onPressed;
  String count;

  Notification_Icon({this.faIcon, this.count, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: new Stack(children: <Widget>[
          faIcon,
          new Positioned(
            // draw a red marble
            top: 0.0,
            right: 0.0,
            child: count.isEmpty
                ? Container()
                : Container(
                    width: 15,
                    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    alignment: Alignment.topRight,
                    child: Center(
                        child: Text(
                      count,
                      style:
                          TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                    ))),
          )
        ]),
        onPressed: this.onPressed);
    ;
  }
}
