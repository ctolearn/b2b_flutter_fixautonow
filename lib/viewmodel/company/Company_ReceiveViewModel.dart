
import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/model/ReceiveBooking.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';

class Company_ReceiveViewModel extends ChangeNotifier {
  ReceiveBooking receiveBooking;
  Company_ReceiveViewModel({this.receiveBooking});

  String bookingStatus() {
    if (receiveBooking.status == "Pending") {
      return receiveBooking.status;
    } else if (receiveBooking.status == "Canceled") {
      return receiveBooking.status;
    } else if (receiveBooking.status == "Work Done") {
      return receiveBooking.status;
    } else if (receiveBooking.status == "Invoiced" &&
        receiveBooking.is_sent != "") {
      return "Invoice_Sent";
    } else if (receiveBooking.status == "Invoiced" &&
        receiveBooking.is_sent == "") {
      return "Invoice_NotSent";
    } else if (receiveBooking.status == "Assigned") {
      return receiveBooking.status;
    } else if (receiveBooking.status == "Accomplished") {
      return receiveBooking.status;
    } else {
      return receiveBooking.status;
    }
  }
}
