import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_AddOnListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookInformationViewModelListener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
class CompanyInvoiceSelectAddOnsListScreen extends StatefulWidget {
  CompanyInvoiceSelectAddOnsListScreen({this.type});

  String type;

  @override
  _CompanyInvoiceSelectAddOnsListScreenState createState() =>
      _CompanyInvoiceSelectAddOnsListScreenState();
}

class _CompanyInvoiceSelectAddOnsListScreenState
    extends State<CompanyInvoiceSelectAddOnsListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var bookViewModelListener = Provider.of<Company_BookInformationViewModelListener>(context);
    var addOnModelListener = Provider.of<Company_AddOnListViewModel>(context);


    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Find Add Ons"),
        ),
        body: ListView(padding: EdgeInsets.all(8), shrinkWrap: true, children: [
          Row(
            children: [
              Expanded(
                  child:
                      Text("AddOn Name").boldText().textColor(Colors.black54)),
              Expanded(
                  child:
                      Text("AddOn Price").boldText().textColor(Colors.black54)),
              Expanded(
                  child: Text("AddOn Description")
                      .boldText()
                      .textColor(Colors.black54)),
              Expanded(
                  child: Text("Control").boldText().textColor(Colors.black54)),
            ],
          ),
          Divider(),
          ListView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: addOnModelListener.apiResponse.data.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                        child: Text(addOnModelListener.apiResponse.data[index].addOn.addon_name)),
                    Expanded(
                        child: Text(addOnModelListener.apiResponse.data[index].addOn.addon_price)),
                    Expanded(
                        child: Text(addOnModelListener.apiResponse.data[index].addOn
                            .addon_description)),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if(widget.type == null) {
                                bookViewModelListener.selectAddOn(
                                    addOnModelListener.apiResponse.data[index]
                                        .addOn);
                                Navigator.pop(context);
                              }else{
                                bookViewModelListener.selectAddOnCreate(
                                    addOnModelListener.apiResponse.data[index]
                                        .addOn);
                                Navigator.pop(context);

                              }
                            },
                            child: Text("Select")))
                  ],
                );
              })
        ]));
  }
}
