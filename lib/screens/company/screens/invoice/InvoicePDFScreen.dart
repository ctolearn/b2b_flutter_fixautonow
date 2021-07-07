import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
class InvoicePDFScreen extends StatefulWidget {
  String path;
  InvoicePDFScreen({Key key,this.path}) : super(key: key);

  @override
  _InvoicePDFScreenState createState() => _InvoicePDFScreenState();
}

class _InvoicePDFScreenState extends State<InvoicePDFScreen> {

  PDFDocument document;
  bool _isLoading = true;
  getPDF() async{

    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL("https://fixautonow.com/"+widget.path,
      /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
    );
    setState(() => _isLoading = false);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPDF();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true),
        body: Container(child: _isLoading ? CircularProgressIndicator() :PDFViewer(
          document: document,
          zoomSteps: 1,),)
    );
  }
}
