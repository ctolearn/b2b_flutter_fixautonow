import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key key}) : super(key: key);

  @override
  _Rate_ScreenState createState() => _Rate_ScreenState();
}

class _Rate_ScreenState extends State<RateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Your Book'),
        centerTitle: true,
      ),
      body: ListView(padding: EdgeInsets.all(18), children: [
        Text(
          "Did you satisfied on your book, give some time to rate us!",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        CupertinoTextField(
          placeholder: "Message",
        ),
        SizedBox(
          height: 10,
        ),
        Center(child:RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 27.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        )),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: () {}, child: Text("Submit"))
      ]),
    );
  }
}
