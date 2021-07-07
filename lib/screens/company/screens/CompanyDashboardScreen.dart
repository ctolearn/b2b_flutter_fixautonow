import 'package:b2b_flutter_fixautonow/custom_ui/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyDashboardBookCardList.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyDashboardBookCardList_Realtime.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyDashboardBookCardList_Requested.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/search/Company_SelectedEmployeeListener.dart';

class CompanyDashboadScreen extends StatefulWidget {
  @override
  _CompanyDashboad_ScreenState createState() => _CompanyDashboad_ScreenState();
}

class _CompanyDashboad_ScreenState extends State<CompanyDashboadScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* Provider.of<Company_DashBoardListModel>(context, listen: false)
        .fetchDashBoard();*/

    Future.delayed(
        Duration.zero,
        () => Provider.of<Company_SelectedEmployeeListener>(context,
                listen: false)
            .reset());
    Provider.of<Company_DashBoardListModel>(context, listen: false)
        .fetchDashBoardCount();
  }

  List<String> dashItem = [
    "Branches",
    "Users",
    "Services",
    "AddOns",
    "Receive Booking",
    "Sent Booking"
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() async {
    // monitor network fetch

    Future.delayed(
        Duration.zero,
            () => Provider.of<Company_SelectedEmployeeListener>(context,
            listen: false)
            .reset());

    Provider.of<Company_DashBoardListModel>(context, listen: false)
        .fetchDashBoardCount();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch


  }

  void _refreshComplete() async {

    Future.delayed(
        Duration.zero,
            () => Provider.of<Company_SelectedEmployeeListener>(context,
            listen: false)
            .reset());
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    var dashboardListModel = Provider.of<Company_DashBoardListModel>(context);

    switch (dashboardListModel.dashBoardCount.status) {
      case Status.ERROR:
        _refreshComplete();
        break;
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        _refreshComplete();
        break;
    }
    Widget gridView = GridView.builder(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      physics: NeverScrollableScrollPhysics(),
      // to disable GridView's scrolling
      shrinkWrap: true,
      // You won't see infinite size error
      itemCount: dashItem.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
        crossAxisCount: 2,
        height: 100.0,
      ),
      itemBuilder: (c, index) {
        Widget itemContainer = Container();
        switch (dashboardListModel.dashBoardCount.status) {
          case Status.ERROR:
            itemContainer = Text("tap to reload").boldText().blackColor();
            break;
          case Status.LOADING:
            itemContainer = CircularProgressIndicator();
            break;
          case Status.COMPLETED:
            itemContainer = Text(
              dashboardListModel.dashBoardCount.data[index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ).boldText().blackColor();
            break;
        }
        return Padding(
            padding: EdgeInsets.all(5),
            child: PhysicalModel(
                elevation: 6.0,
                shape: BoxShape.rectangle,
                shadowColor: Colors.black54,
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  children: [
                    Container(
                        color: Colors.grey,
                        width: double.maxFinite,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              dashItem[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ))),
                    Expanded(child: Center(child: itemContainer))
                  ],
                )));
      },
      // Generate 100 widgets that display their index in the List.
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: MaterialClassicHeader(),
            controller: _refreshController,
            onRefresh: onRefresh,
            onLoading: _onLoading,
            child: dashboardListModel.dashBoardCount.status == Status.ERROR
                ? Container(child: Text("Tap to reload"))
                : ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      gridView,
                      CompanyDashboardBookCardList_Realtime(
                        itemList: dashboardListModel
                                    .companyDashboardItemList.status ==
                                Status.COMPLETED
                            ? dashboardListModel.companyDashboardItemList.data
                                .where((element) =>
                                    element.dashBoardBook.status == "1" &&
                                    element.dashBoardBook.is_you == "n")
                                .toList()
                            : [],
                        title: "Realtime Booking",
                        no_data: "No Booking Available",
                      ),
                      CompanyDashboardBookCardList_Requested(
                        itemList: dashboardListModel
                                    .companyDashboardItemList.status ==
                                Status.COMPLETED
                            ? dashboardListModel.companyDashboardItemList.data
                                .where((element) =>
                                    element.dashBoardBook.status == "1" &&
                                    element.dashBoardBook.is_you == "y")
                                .toList()
                            : [],
                        title: "Requested Booking",
                        no_data: "No Requested Booking",
                      ),
                      CompanyDashboardBookCardList(
                        itemList: dashboardListModel
                                    .companyDashboardItemList.status ==
                                Status.COMPLETED
                            ? dashboardListModel.companyDashboardItemList.data
                                .where((element) =>
                                    element.dashBoardBook.status == "2" &&
                                    element.dashBoardBook.is_you == "y")
                                .toList()
                            : [],
                        title: "Requested Booking",
                        no_data: "No Requested Booking",
                      ),
                    ],
                  )));
  }
/*   var dashboardListModel = Provider.of<Company_DashBoardListModel>(context);
    Widget gridView = GridView.builder(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.

      physics: NeverScrollableScrollPhysics(),
      // to disable GridView's scrolling
      shrinkWrap: true,
      // You won't see infinite size error
      itemCount: dashItem.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
        crossAxisCount: 3,
        height: 100.0,
      ),
      itemBuilder: (c, index) {
        return Card(
            child: Column(
          children: [
            Container(
                color: Colors.grey,
                width: double.maxFinite,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      dashItem[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white70),
                    ))),
            Expanded(
                child: Center(
                    child: dashboardListModel.status_count == Status.LOADING
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            dashboardListModel.dashBoardCount[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )))
          ],
        ));
      },
      // Generate 100 widgets that display their index in the List.

    );

    return ListView(padding: EdgeInsets.all(8), shrinkWrap: true, children: [
      gridView,
      CompanyDashboard_BookCard(
        dashboardListModel: dashboardListModel,
        title: "Realtime Booking",
        no_data: "No Booking Available",
      ),
      CompanyDashboard_BookCard(
        dashboardListModel: dashboardListModel,
        title: "Requested Booking",
        no_data: "No Requested Booking",
      ),
      CompanyDashboard_BookCard(
        dashboardListModel: dashboardListModel,
        title: "Un-Assigned Booking",
        no_data: "No Un-Assigned",
      ),
    ]);
  }*/
}
