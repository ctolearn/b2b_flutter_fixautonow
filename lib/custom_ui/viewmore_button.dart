import 'package:flutter/material.dart';

class ViewMore_Button extends StatelessWidget {
  String title;
  VoidCallback onTap;
  ViewMore_Button({Key key,this.title,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child:ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: 25),
        child: ElevatedButton(
          onPressed:onTap,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          child: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        )));
  }
}
