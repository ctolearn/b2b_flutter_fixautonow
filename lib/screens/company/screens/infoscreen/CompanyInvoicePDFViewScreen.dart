
import 'package:flutter/material.dart';
class CompanyInvoiceViewScreen extends StatefulWidget {
  CompanyInvoiceViewScreen({Key key,this.path}) : super(key: key);
  String path;
  @override
  _Invoice_ScreenState createState() => _Invoice_ScreenState();
}

class _Invoice_ScreenState extends State<CompanyInvoiceViewScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoice Information"),),
      body: Container(),
    );
  }
}
