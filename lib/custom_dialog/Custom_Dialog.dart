import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    this.title,
    this.message,
    this.yesCallBack,
    this.noCallBack,
  });

  String title;
  String message;
  VoidCallback yesCallBack;
  VoidCallback noCallBack;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: yesCallBack, child: Text("Yes")),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: noCallBack,
                        child: Text(
                          "No",
                        ))
                  ],
                )
              ],
            )));
  }
}
