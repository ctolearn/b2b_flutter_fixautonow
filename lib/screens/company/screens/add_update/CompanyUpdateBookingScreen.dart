import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyUpdateBookingScreen extends StatefulWidget {
  CompanyUpdateBookingScreen({this.book_id});

  String book_id;

  @override
  _CompanyUpdateBooking_ScreenState createState() =>
      _CompanyUpdateBooking_ScreenState();
}

class _CompanyUpdateBooking_ScreenState
    extends State<CompanyUpdateBookingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update Booking"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        children: [
          Text("Customer Service Price Request")
              .boldText()
              .textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          Text("Vehicle Type").boldText().textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          Text("Vehicle Make").boldText().textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          Text("Vehicle Model").boldText().textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Text("Date").boldText().textColor(Colors.black54),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: false,
                    hintText: "",
                    color: Colors.white,
                  )
                ],
              )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Column(
                children: [
                  Text("Time").boldText().textColor(Colors.black54),
                  CircularTextField(
                    descorationSize: DecorationSize.SMALL,
                    isEnabled: false,
                    hintText: "",
                    color: Colors.white,
                  )
                ],
              )),
            ],
          ),
          Text("Plate Number").boldText().textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          Text("Remarks").boldText().textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          Text("Service").boldText().textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          Text("Select Employee").boldText().textColor(Colors.black54),
          CircularTextField(
            descorationSize: DecorationSize.SMALL,
            isEnabled: false,
            hintText: "",
            color: Colors.white,
          ),
          ElevatedButton(onPressed: () {}, child: Text("Update"))
        ],
      ),
    );
  }
}
