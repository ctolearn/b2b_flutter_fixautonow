import 'package:flutter/material.dart';
class DashboardItem_Button extends StatelessWidget {
  String button_title;
  VoidCallback onPressed;
   DashboardItem_Button({Key key,this.button_title,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ConstrainedBox(
          constraints:
          BoxConstraints.tightFor(height: 25),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(
                    Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                )
            ),
            child: Text(
              button_title,
              style: TextStyle(fontSize: 12,color: Colors.white),
            ),
          ));
  }
}
