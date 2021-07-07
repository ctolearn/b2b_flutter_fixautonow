import 'package:flutter/material.dart';
class EmptyScreenResponse extends StatelessWidget {
  String message;
  EmptyScreenResponse({Key key,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child:Text(message != null ? message:"No Data Available",style: TextStyle(fontWeight: FontWeight.bold),),));
  }
}
