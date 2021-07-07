import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/model/ServiceImage.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/services/ServicesAvailableListViewModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ServiceAvailableScreen extends StatefulWidget {
  ServiceImage service_image;

  ServiceAvailableScreen({this.service_image});

  @override
  _ServiceAvailableScreenState createState() => _ServiceAvailableScreenState();
}

class _ServiceAvailableScreenState extends State<ServiceAvailableScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ServicesAvailableListViewModel>(context, listen: false)
        .fetchService(widget.service_image.title);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() async {
    // monitor network fetch

    Provider.of<ServicesAvailableListViewModel>(context, listen: false)
        .fetchService(widget.service_image.title);
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch

    Provider.of<ServicesAvailableListViewModel>(context, listen: false)
        .fetchService(widget.service_image.title);
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<ServicesAvailableListViewModel>(context);
    Widget containerWidget = Container();
    switch (listViewModel.fetchServiceAvailableModel.status) {
      case Status.LOADING:
        break;
      case Status.EMPTY:
        _refreshComplete();
        containerWidget = EmptyScreenResponse();
        break;
      case Status.ERROR:
        _refreshComplete();
        containerWidget = ErrorScreenResponse();
        break;
      case Status.COMPLETED:
        _refreshComplete();
        containerWidget = ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: listViewModel.fetchServiceAvailableModel.data.length,
            itemBuilder: (context, index) {
              double rate = double.parse(listViewModel
                      .fetchServiceAvailableModel
                      .data[index]
                      .serviceItem
                      .rating
                      .isEmpty
                  ? "0.0"
                  : listViewModel.fetchServiceAvailableModel.data[index]
                      .serviceItem.rating);
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IntrinsicHeight(
                      child: Column(children: [
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
                                    listViewModel.fetchServiceAvailableModel
                                        .data[index].serviceItem.name,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.car,
                                        size: 15,
                                      ),
                                      Flexible(
                                          child: RichText(
                                        text: TextSpan(
                                          text: ' Vehicle Type : ',
                                          style:
                                              TextStyle(color: Colors.black54),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: listViewModel
                                                    .fetchServiceAvailableModel
                                                    .data[index]
                                                    .serviceItem
                                                    .vehicle_type,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.car,
                                        size: 15,
                                      ),
                                      Flexible(
                                          child: RichText(
                                        text: TextSpan(
                                          text: ' Company Name : ',
                                          style:
                                              TextStyle(color: Colors.black54),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: listViewModel
                                                    .fetchServiceAvailableModel
                                                    .data[index]
                                                    .serviceItem
                                                    .company_name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.car,
                                        size: 15,
                                      ),
                                      Flexible(
                                          child: RichText(
                                        text: TextSpan(
                                          text: ' Location : ',
                                          style:
                                              TextStyle(color: Colors.black54),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: listViewModel
                                                    .fetchServiceAvailableModel
                                                    .data[index]
                                                    .serviceItem
                                                    .company_address,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.car,
                                        size: 15,
                                      ),
                                      Flexible(
                                          child: RichText(
                                        text: TextSpan(
                                          text: ' Distance : ',
                                          style:
                                              TextStyle(color: Colors.black54),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: listViewModel
                                                    .fetchServiceAvailableModel
                                                    .data[index]
                                                    .serviceItem
                                                    .distance,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                  Divider(),
                                  Text(listViewModel.fetchServiceAvailableModel
                                      .data[index].serviceItem.work_types),
                                  Divider(),
                                  Row(children: [
                                    RatingBar.builder(
                                      initialRating: rate,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 18.0,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    Expanded(
                                        child: Text(listViewModel
                                                .fetchServiceAvailableModel
                                                .data[index]
                                                .serviceItem
                                                .rating
                                                .isEmpty
                                            ? "No Rating"
                                            : listViewModel
                                                .fetchServiceAvailableModel
                                                .data[index]
                                                .serviceItem
                                                .rating))
                                  ]),
                                  Divider(),

                                  /*            Text(
                                        "Company Name",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(outlierListModel
                                          .outlierListViewModel[index]
                                          .companyName),
                                      Text(
                                        "Country",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(outlierListModel
                                          .outlierListViewModel[index]
                                          .outlier
                                          .no_parent_country),
                                      Text(
                                        "Address",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(outlierListModel
                                          .outlierListViewModel[index]
                                          .outlier
                                          .no_parent_address),*/
                                ],
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(fit: FlexFit.tight, child: Container()),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(5.0),
                                )),
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/book',
                                            arguments: listViewModel
                                                .fetchServiceAvailableModel
                                                .data[index]
                                                .serviceItem
                                                .service_id);
                                      },
                                      child: Text(
                                        "Book Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ))),
                      ],
                    )
                  ])));
            });
        break;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.service_image.name),
      ),
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
