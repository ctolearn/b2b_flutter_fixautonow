import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookInformationViewModelListener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';

class CompanyInvoiceWorkTypeList_Screen extends StatefulWidget {
  String type;

  CompanyInvoiceWorkTypeList_Screen({this.type});

  @override
  _CompanyInvoiceWorkTypeList_ScreenState createState() =>
      _CompanyInvoiceWorkTypeList_ScreenState();
}

class _CompanyInvoiceWorkTypeList_ScreenState
    extends State<CompanyInvoiceWorkTypeList_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bookListener =
        Provider.of<Company_BookInformationViewModelListener>(context);
    if (widget.type == null) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Find Service Types"),
          ),
          body:
              ListView(padding: EdgeInsets.all(8), shrinkWrap: true, children: [
            Row(
              children: [
                Expanded(
                    child: Text("Name").boldText().textColor(Colors.black54)),
                Expanded(
                    child: Text("Description")
                        .boldText()
                        .textColor(Colors.black54)),
                Expanded(
                    child: Text("Price").boldText().textColor(Colors.black54)),
                Expanded(
                    child:
                        Text("Control").boldText().textColor(Colors.black54)),
              ],
            ),
            Divider(),
            ListView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                itemCount: bookListener.fetchInvoiceInformation.data
                    .invoice_information.companyWorkTypes.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(bookListener
                              .fetchInvoiceInformation
                              .data
                              .invoice_information
                              .companyWorkTypes[index]
                              .type_name)),
                      Expanded(
                          child: Text(bookListener
                              .fetchInvoiceInformation
                              .data
                              .invoice_information
                              .companyWorkTypes[index]
                              .type_description)),
                      Expanded(
                          child: Text(bookListener
                              .fetchInvoiceInformation
                              .data
                              .invoice_information
                              .companyWorkTypes[index]
                              .type_price)),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                bookListener.selectedType(bookListener
                                    .fetchInvoiceInformation
                                    .data
                                    .invoice_information
                                    .companyWorkTypes[index]);
                                /*   bookViewModelData.selectAddOn(bookViewModel.book_viewModel_invoice
                                    .invoice_information.companyWorkTypes[index]);*/
                                //bookViewModelData.selectedType()
                              },
                              child: Text("Select")))
                    ],
                  );
                })
          ]));
    } else {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Find Service Types"),
          ),
          body:
              ListView(padding: EdgeInsets.all(8), shrinkWrap: true, children: [
            Row(
              children: [
                Expanded(
                    child: Text("Name").boldText().textColor(Colors.black54)),
                Expanded(
                    child: Text("Description")
                        .boldText()
                        .textColor(Colors.black54)),
                Expanded(
                    child: Text("Price").boldText().textColor(Colors.black54)),
                Expanded(
                    child:
                        Text("Control").boldText().textColor(Colors.black54)),
              ],
            ),
            Divider(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: bookListener.fetchBookInformation.data
                    .booking_information.companyWorkTypes.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(bookListener.fetchBookInformation.data
                              .booking_information
                              .companyWorkTypes[index]
                              .type_name)),
                      Expanded(
                          child: Text(bookListener.fetchBookInformation.data
                              .booking_information
                              .companyWorkTypes[index]
                              .type_description)),
                      Expanded(
                          child: Text(bookListener.fetchBookInformation.data
                              .booking_information
                              .companyWorkTypes[index]
                              .type_price)),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                bookListener.selectedTypeCreate(bookListener.fetchBookInformation.data
                                    .booking_information
                                    .companyWorkTypes[index]);

                              },
                              child: Text("Select")))
                    ],
                  );
                })
          ]));
    }
  }
}
