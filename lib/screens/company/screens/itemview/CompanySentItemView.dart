import 'package:b2b_flutter_fixautonow/custom_dialog/CustomDialogViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/Custom_Dialog.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/SentBooking.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_SentListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_SentViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CompanySentItemView extends StatelessWidget {
  Company_SentViewModel company_sentViewModel;
  BuildContext buildContext;
  MessageCallBack messageCallBack;
  CompanySentItemView({this.company_sentViewModel,@required this.buildContext,this.messageCallBack});

  void moveToSentViewInformation(BuildContext context) {
    Map<String, dynamic> objToPass = new Map();
    objToPass.putIfAbsent(
        "book_id", () => company_sentViewModel.sentBooking.booking_id);
    objToPass.putIfAbsent(
        "type", () => company_sentViewModel.sentBooking.status);
    Navigator.pushNamed(context, "/sentview", arguments: objToPass);
  }
  void moveToChatScreen(BuildContext context){

    Map<String,dynamic> mapData = new Map();
    mapData.putIfAbsent("to_user", () => company_sentViewModel.sentBooking.company_seller_id);
    mapData.putIfAbsent("booking_id", () => company_sentViewModel.sentBooking.booking_id);
    Navigator.of(context).pushNamed("/chat",arguments:mapData);
  }
  void moveToRateScreen(BuildContext context){
    Navigator.pushNamed(context, "/rate");
  }
  @override
  Widget build(BuildContext context) {
    SentBooking sentBooking = company_sentViewModel.sentBooking;
    Widget widget;
    switch (company_sentViewModel.sentBooking.status) {
      case "Pending":
        widget = Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {
                      _cancelBooking(context,"cancel");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.ban,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      moveToSentViewInformation(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      moveToChatScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.comments,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ));
        break;
      case "Accepted":
        widget = Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {

                      _cancelBooking(context,"cancel");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.ban,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      moveToSentViewInformation(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      //onClick("info");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.comments,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ));
        break;
      case "Canceled":
        widget = Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {

                      moveToSentViewInformation(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ));
        break;
      case "Realtime":
        widget = Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {

                      moveToSentViewInformation(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ));
        break;
      case "Accomplished":
        widget = Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {
                      moveToRateScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.starHalfAlt,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {

                      moveToSentViewInformation(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      if (company_sentViewModel.sentBooking.path.isEmpty) {
                        //onClick("no_invoice");
                      } else {
                        Navigator.pushNamed(context, "/invoice_pdf_view",arguments:company_sentViewModel.sentBooking
                            .path );
                      }
                    },
                    child: FaIcon(
                      FontAwesomeIcons.fileInvoiceDollar,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      moveToChatScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.comments,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ));
        break;
      case "Invoiced":
        widget = Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {
                      moveToSentViewInformation(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      if (company_sentViewModel.sentBooking.path.isEmpty) {
                        //onClick("no_invoice");
                      } else {
                        Navigator.pushNamed(context, "/invoice_pdf_view",arguments:company_sentViewModel.sentBooking
                            .path );
                      }
                    },
                    child: FaIcon(
                      FontAwesomeIcons.fileInvoiceDollar,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {

                      moveToChatScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.comments,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ));
        break;
      default:
        widget = Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () {
                      moveToSentViewInformation(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.infoCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {

                      moveToChatScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.comments,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ));
        break;
    }
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: PhysicalModel(
            elevation: 6.0,
            shape: BoxShape.rectangle,
            shadowColor: Colors.black54,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            child: Card(
                elevation: 0,
                child: IntrinsicHeight(
                    child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                              child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "REF # " + company_sentViewModel.sentBooking.ref,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(25.0),
                              )),
                          child: widget),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vehicle Type",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel
                                    .sentBooking.vehicle_type),
                                Text(
                                  "Vehicle Make",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel
                                    .sentBooking.vehicle_make),
                                Text(
                                  "Vehicle Model",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel
                                    .sentBooking.vehicle_model),
                                Text(
                                  "Vehicle Year",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel
                                    .sentBooking.vehicle_year),
                                Text(
                                  "Plate Number",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel
                                    .sentBooking.plate_number),
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel.sentBooking.date),
                                Text(
                                  "Time",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel.sentBooking.time),
                                Text(
                                  "Status",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_sentViewModel.sentBooking.status),
                              ],
                            ),
                          )),
                    ],
                  ),
                ])))));
  }

  void _cancelBooking(BuildContext context, String type) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          this.buildContext = context;
          var addOnList = Provider.of<Company_SentListViewModel>(context);
          if (addOnList.crudResponse.crudType == "delete") {
            print(addOnList.crudResponse.status);
            switch (addOnList.crudResponse.status) {
              case Status.COMPLETED:
                closeDialog();
                messageCallBack.showMessage("Branch item has been deleted");
                Provider.of<Company_SentListViewModel>(buildContext,
                    listen: false)
                    .fetchSentBooking();
                break;
              case Status.ERROR:
                messageCallBack
                    .showMessage("Deleting Failed, Check your connection");
                Provider.of<Company_SentListViewModel>(buildContext,
                    listen: false)
                    .resetCrud();
                break;
            }
          }
          var dialogModel = CustomDialogViewModel(type: type);
          return new WillPopScope(
              onWillPop: () async => false,
              child: CustomDialog(
                title: dialogModel.getTitle(),
                message: dialogModel.getMessage(),
                yesCallBack: (addOnList.crudResponse.status == Status.LOADING &&
                    addOnList.crudResponse.crudType == "delete")
                    ? null
                    : deleteCallBack,
                noCallBack: (addOnList.crudResponse.status == Status.LOADING &&
                    addOnList.crudResponse.crudType == "delete")
                    ? null
                    : closeDialog,
              ));
        });
  }

  void deleteCallBack() {
    Provider.of<Company_SentListViewModel>(buildContext)
        .cancelBooking(company_sentViewModel.sentBooking.booking_id);
  }

  void closeDialog() {
    Navigator.of(buildContext).pop();
  }
}
