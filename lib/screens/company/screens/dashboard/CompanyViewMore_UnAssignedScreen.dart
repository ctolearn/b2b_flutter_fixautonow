import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyDashboardBookCardList.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/dashboard/Company_ViewMoreListViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyViewMore_UnassignedItemView.dart';

class CompanyViewMore_UnAssignedScreen extends StatefulWidget {
  const CompanyViewMore_UnAssignedScreen({Key key}) : super(key: key);

  @override
  _CompanyViewMore_UnAssignedScreenState createState() =>
      _CompanyViewMore_UnAssignedScreenState();
}

class _CompanyViewMore_UnAssignedScreenState
    extends State<CompanyViewMore_UnAssignedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_ViewMoreListViewModel>(context, listen: false)
        .fetchViewMoreList();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_ViewMoreListViewModel>(context, listen: false)
        .fetchViewMoreList();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_ViewMoreListViewModel>(context, listen: false)
        .fetchViewMoreList();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    var dashboardListModel =
        Provider.of<Company_ViewMoreListViewModel>(context);
    Widget itemContainer = Container();
    switch (dashboardListModel.companyViewMoreItemList.status) {
      case Status.ERROR:
        _refreshComplete();
        break;
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        _refreshComplete();
        List<Company_DashBoardModel> itemList = dashboardListModel
            .companyViewMoreItemList.data
            .where((element) =>
                element.dashBoardBook.status == "2" &&
                element.dashBoardBook.is_you == "y")
            .toList();
        itemContainer = ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return CompanyViewMore_UnassignedItemView(
                company_dashBoardModel: itemList[index],
              );
            });

        /*CompanyViewMore_UnassignedItemView(
          itemList: dashboardListModel.companyViewMoreItemList.status ==
              Status.COMPLETED
              ? dashboardListModel.companyViewMoreItemList.data
              .where((element) =>
          element.dashBoardBook.status == "2" &&
              element.dashBoardBook.is_you == "y")
              .toList()
              : [],
          title: "Requested Booking",
          no_data: "No Requested Booking",
        );*/
        break;
    }
    return Scaffold(
        appBar: AppBar(centerTitle: true,title: Text("UnAssigned List"),),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: MaterialClassicHeader(),
          controller: _refreshController,
          onRefresh: onRefresh,
          onLoading: _onLoading,
          child: itemContainer,
        ));
  }
}
