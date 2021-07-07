import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookInformationViewModelListener.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class CompanyViewReceiveInfoScreen extends StatefulWidget {
  String book_id;

  CompanyViewReceiveInfoScreen({this.book_id});

  @override
  _CompanyViewReceiveInfoScreenState createState() =>
      _CompanyViewReceiveInfoScreenState();
}

class _CompanyViewReceiveInfoScreenState
    extends State<CompanyViewReceiveInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_BookInformationViewModelListener>(context,
            listen: false)
        .fetchReceiveBookingInformation(widget.book_id);

  }
  void onRefresh() async {
    // monitor network fetch

    Provider.of<Company_BookInformationViewModelListener>(context,
        listen: false)
        .fetchReceiveBookingInformation(widget.book_id);
  }

  void _onLoading() {
    // monitor network fetch

    Provider.of<Company_BookInformationViewModelListener>(context,
        listen: false)
        .fetchReceiveBookingInformation(widget.book_id);
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    var bookViewModelListener =
        Provider.of<Company_BookInformationViewModelListener>(context);
    Widget containerWidget = Container();
    if (bookViewModelListener.fetchBookingReceiveInformation.status != null) {
      switch (bookViewModelListener.fetchBookingReceiveInformation.status) {
        case Status.ERROR:
          _refreshComplete();
          containerWidget = EmptyScreenResponse();
          break;
        case Status.COMPLETED:
          _refreshComplete();
          containerWidget = ListView(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              children: [
                Text(
                  "Vehicle Images",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                        bookViewModelListener.fetchBookingReceiveInformation
                            .data.bookReceive_Info.urls.length >
                            4
                            ? 4
                            : bookViewModelListener
                            .fetchBookingReceiveInformation
                            .data
                            .bookReceive_Info
                            .urls
                            .length, (index) {
                      return Image.network(
                        "http://fixautonow.com/" +
                            bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .urls[index]
                                .url,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                      );
                    })),
                Text(
                  "Service Data",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                Divider(),
                Text(
                  "Service Name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                Text(
                  bookViewModelListener.fetchBookingReceiveInformation.data
                      .bookReceive_Info.service_name,
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  "Service Types",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                ListView.builder(
                    itemCount: bookViewModelListener
                        .fetchBookingReceiveInformation
                        .data
                        .bookReceive_Info
                        .service_types
                        .length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text("\u2022 "),
                          Expanded(
                              child: Text(bookViewModelListener
                                  .fetchBookingReceiveInformation
                                  .data
                                  .bookReceive_Info
                                  .service_types[index]
                                  .toString()))
                        ],
                      );
                    }),
                Row(
                  children: [
                    //vehicle data
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehicle Data",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Divider(),
                            Text(
                              "Vehicle Identification Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .vin),
                            Text(
                              "Vehicle Model",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .vehicle_model),
                            Text(
                              "Vehicle Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .vehicle_type),
                            Text(
                              "Vehicle Make",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .vehicle_make),
                            Text(
                              "Vehicle Year",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .vehicle_year),
                          ],
                        )),
                    //company buyer data
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Company Buyer Data",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Divider(),
                            Text(
                              "Company Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .company_name),
                            Text(
                              "Company Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .company_address),
                            Text(
                              "Company Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .company_email),
                            Text(
                              "Company Contact",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .company_contact),
                            Text(
                              "Company Country",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(bookViewModelListener
                                .fetchBookingReceiveInformation
                                .data
                                .bookReceive_Info
                                .company_country),
                          ],
                        ))
                  ],
                )
              ]);
          break;
        case Status.LOADING:
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Receive Booking Information"),),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: _onLoading,
        child: containerWidget,
      ),
    );
  }


}
