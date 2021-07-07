
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Book_AddOn.dart';
import 'package:b2b_flutter_fixautonow/model/Book_WorkType.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookInformationViewModelListener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CompanyViewInvoiceScreen extends StatefulWidget {
  String book_id;
  CompanyViewInvoiceScreen({this.book_id});

  @override
  _CompanyViewInvoice_ScreenState createState() =>
      _CompanyViewInvoice_ScreenState();
}

class _CompanyViewInvoice_ScreenState extends State<CompanyViewInvoiceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_BookInformationViewModelListener>(context,listen: false).fetchBookingInvoiceInformation(widget.book_id);
  }


  @override
  Widget build(BuildContext context) {
    var invoiceListener = Provider.of<Company_BookInformationViewModelListener>(context);

    Widget widget = Container();
    if(invoiceListener.fetchInvoiceInformation.status != null) {
      switch (invoiceListener.fetchInvoiceInformation.status) {
        case Status.EMPTY:
          break;
        case Status.ERROR:
          break;
        case Status.COMPLETED:

          widget = ListView(
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Date : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'bold', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Bill To: ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.companyNameTo(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Address : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.address,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Phone : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.contact,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Email : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.email,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Divider(),
              RichText(
                text: TextSpan(
                  text: 'Bill From : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.companyNameFrom(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Address : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.seller_address,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Phone : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.seller_contact,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Email : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text:invoiceListener.fetchInvoiceInformation.data.invoice_information.seller_email,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Divider(),
              Text(
                "Car Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              RichText(
                text: TextSpan(
                  text: 'Model : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.model,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Plate : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.plate_number,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Text(
                "Service Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              RichText(
                text: TextSpan(
                  text: 'Name : ',
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                        text: invoiceListener.fetchInvoiceInformation.data.invoice_information.service_name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Divider(),
              Text(
                "Type of Service List",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Divider(),
              invoiceListener.fetchInvoiceInformation.data.invoice_information.bookWorkTypes
                  .length ==
                  0
                  ? Text("No Data Available")
                  : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text("# Item",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Item",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                    ],
                  ),
                  Divider(),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: invoiceListener.fetchInvoiceInformation.data.invoice_information.bookWorkTypes.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Book_WorkType workType = invoiceListener.fetchInvoiceInformation.data.invoice_information
                            .bookWorkTypes[index];
                        return Row(
                          children: [
                            Expanded(child: Text("1")),
                            Expanded(child: Text(workType.name)),
                            Expanded(child: Text(workType.description)),
                            Expanded(child: Text("\$ " + workType.price)),
                            Expanded(child: Text("\$ " + workType.price)),
                          ],
                        );
                      }),
                ],
              ),
              Text(
                "Add Ons List",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              invoiceListener.fetchInvoiceInformation.data.invoice_information.bookAddOns
                  .length ==
                  0
                  ? Text("No Data Available")
                  : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text("# Item",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Item",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      Expanded(
                          child: Text("Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                    ],
                  ),
                  Divider(),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: invoiceListener.fetchInvoiceInformation.data.invoice_information.bookAddOns.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Book_AddOn addOn = invoiceListener.fetchInvoiceInformation.data.invoice_information.bookAddOns[index];
                        return Row(
                          children: [
                            Expanded(child: Text(addOn.count)),
                            Expanded(child: Text(addOn.name)),
                            Expanded(child: Text(addOn.description)),
                            Expanded(child: Text("\$ " + addOn.price)),
                            Expanded(child: Text("\$ " + addOn.total)),
                          ],
                        );
                      }),
                  Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Send Invoice")))
                ],
              )
            ],
          );
          break;
        case Status.LOADING:
          break;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Invoice"),
          centerTitle: true,
        ),
        body: widget);
  }
}

