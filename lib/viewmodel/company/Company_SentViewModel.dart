

import 'package:b2b_flutter_fixautonow/api_response/Api_Response.dart';
import 'package:b2b_flutter_fixautonow/model/SentBooking.dart';
import 'package:b2b_flutter_fixautonow/repository/WebRepository.dart';
import 'package:flutter/cupertino.dart';



class Company_SentViewModel{
  SentBooking sentBooking;
  Company_SentViewModel({this.sentBooking});

/*  List<Company_SentViewModel> companySentListViewModel = [];
  Status status = Status.EMPTY;
  Status status_delete = Status.EMPTY;

  void fetchSentBooking() async {
    status = Status.LOADING;
    List<SentBooking> sentList = await WebService().fetchSent();
    notifyListeners();
    this.companySentListViewModel = sentList
        .map((item) => Company_SentViewModel(sentBooking: item))
        .toList();
    if (companySentListViewModel.isEmpty) {
      status = Status.EMPTY;
    } else {
      status = Status.COMPLETED;
    }
    notifyListeners();
  }*/
}
