import 'package:b2b_flutter_fixautonow/custom_dialog/CustomDialogViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/Custom_Dialog.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ReceiveListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ReceiveViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
class  CompanyReceiveItemView extends StatelessWidget {
  Company_ReceiveViewModel company_receiveViewModel;
  MessageCallBack messageCallBack;
  BuildContext buildContext;
  CompanyReceiveItemView({this.company_receiveViewModel,this.messageCallBack});
  void moveToReceiveViewInformation(BuildContext context) {
    Navigator.pushNamed(context, "/receiveview",arguments: company_receiveViewModel
        .receiveBooking.booking_id);
  }
  void moveToUpdateBookingScreen(BuildContext context) {
    Navigator.pushNamed(context, "/updatereceivebooking",arguments: company_receiveViewModel
        .receiveBooking.booking_id);
  }
  void moveToCreateInvoicScreen(BuildContext context) {
    Navigator.pushNamed(context, "/createinvoice",arguments: company_receiveViewModel
        .receiveBooking.booking_id);

  }
  void moveToUpdateInvoiceScreen(BuildContext context) {
    Navigator.pushNamed(context, "/updateinvoice_receive",arguments: company_receiveViewModel
        .receiveBooking.booking_id);

  }
  void moveToViewInvoiceScreeen(BuildContext context) {
    Navigator.pushNamed(context, "/viewinvoice_receive",arguments: company_receiveViewModel
        .receiveBooking.booking_id);

  }
  void moveToChatScreen(BuildContext context){

    Map<String,dynamic> mapData = new Map();
    mapData.putIfAbsent("to_user", () => company_receiveViewModel.receiveBooking.company_buyer_id);
    mapData.putIfAbsent("booking_id", () => company_receiveViewModel.receiveBooking.booking_id);
    Navigator.of(context).pushNamed("/chat",arguments:mapData);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build\
    Widget widget;
    switch (company_receiveViewModel.bookingStatus()) {
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
                      moveToReceiveViewInformation(context);
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
                      _processBookingDialog(context,"accept");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.checkCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      //onClick("delete");
                      _processBookingDialog(context,"decline");
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
                      /** chat */
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

                      moveToReceiveViewInformation(context);
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
      case "Work Done":
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

                      moveToCreateInvoicScreen(context);
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
                      /** MAKE INVOICE **/
                      moveToCreateInvoicScreen(context);


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
                      /** chat */
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
      case "Invoice_Sent":
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

                      moveToReceiveViewInformation(context);
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
                      /** accomplish */
                      _processBookingDialog(context, "accomplish");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.checkCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      moveToViewInvoiceScreeen(context);
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
                      /** edit invoice */
                      moveToUpdateInvoiceScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.edit,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      /** chat */
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
      case "Invoice_NotSent":
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
                      moveToReceiveViewInformation(context);
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
                      /** invoivce info */
                      moveToViewInvoiceScreeen(context);
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
                      /** edit invoice */
                      moveToUpdateInvoiceScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.edit,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      /** chat */
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
      case "Assigned":
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

                      moveToReceiveViewInformation(context);
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
                      /** complete booking */
                      //onClick("complete");
                      _processBookingDialog(context, "complete");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.checkCircle,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      //onClick("delete");
                      _processBookingDialog(context,"decline");
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
                      /** edit booking */
                      moveToUpdateBookingScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.edit,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      /** chat */
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

                      moveToReceiveViewInformation(context);
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

                      moveToViewInvoiceScreeen(context);
                      //onClick("info");
            /*          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompanyViewInvoice_Screen(
                              book_id: company_receiveViewModel
                                  .receiveBooking.booking_id,
                            )),
                      );*/
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
                      /** chat */
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

                      moveToReceiveViewInformation(context);
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
                      //onClick("delete");
                      _processBookingDialog(context,"decline");
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
                      /** edit booking  */
                      moveToUpdateBookingScreen(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.edit,
                      size: 15,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      /** chat */
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
    return Padding(padding: EdgeInsets.only(bottom:10),child:PhysicalModel(
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
                                  "REF # " +
                                      company_receiveViewModel.receiveBooking.ref,
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
                            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
                                Text(company_receiveViewModel
                                    .receiveBooking.vehicle_type),
                                Text(
                                  "Vehicle Make",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_receiveViewModel
                                    .receiveBooking.vehicle_make),
                                Text(
                                  "Vehicle Model",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_receiveViewModel
                                    .receiveBooking.vehicle_model),
                                Text(
                                  "Vehicle Year",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_receiveViewModel
                                    .receiveBooking.vehicle_year),
                                Text(
                                  "Plate Number",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_receiveViewModel
                                    .receiveBooking.plate_number),
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_receiveViewModel.receiveBooking.date),
                                Text(
                                  "Time",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(company_receiveViewModel.receiveBooking.time),
                                Text(
                                  "Status",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                    company_receiveViewModel.receiveBooking.status),
                              ],
                            ),
                          )),
                    ],
                  ),
                ])))));
  }


  void _processBookingDialog(BuildContext context, String type) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          VoidCallback callback;
          this.buildContext = context;
          var addOnList = Provider.of<Company_ReceiveListViewModel>(context);

          switch(type){
            case "decline":
              callback = deleteCallBack;
              break;
            case "accept":
              callback = deleteCallBack;
              break;
            case "complete":
              callback = deleteCallBack;
              break;
            case "accomplish":
              callback = deleteCallBack;
              break;
          }


          if (addOnList.crudResponse.crudType == "process") {
            print(addOnList.crudResponse.status);
            switch (addOnList.crudResponse.status) {
              case Status.COMPLETED:
                closeDialog();
                messageCallBack.showMessage("Outlier item has been deleted");
                Provider.of<Company_ReceiveListViewModel>(context, listen: false)
                    .fetchReceiveBooking();
                break;
              case Status.ERROR:
                messageCallBack
                    .showMessage("Deleting Failed, Check your connection");

                Provider.of<Company_ReceiveListViewModel>(context, listen: false)
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
                    addOnList.crudResponse.crudType == "process")
                    ? null
                    : callback,
                noCallBack: (addOnList.crudResponse.status == Status.LOADING &&
                    addOnList.crudResponse.crudType == "process")
                    ? null
                    : closeDialog,
              ));
        });
  }


  void deleteCallBack() {
    Provider.of<Company_ReceiveListViewModel>(buildContext)
        .cancelBooking(company_receiveViewModel.receiveBooking.booking_id);
  }

  void closeDialog() {
    Navigator.of(buildContext).pop();
  }
}
