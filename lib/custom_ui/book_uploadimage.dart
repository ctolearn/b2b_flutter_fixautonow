import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Book_UploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 5),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Container(child:Text(

            "Upload image of your car left, right, front and back",textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10,color: Colors.black54,),
          ))
        );
  }
}
