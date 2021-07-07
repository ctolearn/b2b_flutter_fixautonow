import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyDashboardBookCardList_Realtime.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/dashboard/Company_ViewMoreListViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyViewMore_RealtimeItemView.dart';

class CompanyViewMore_RealtimeScreen extends StatefulWidget {
  const CompanyViewMore_RealtimeScreen({Key key}) : super(key: key);

  @override
  _CompanyViewMore_RealtimeScreenState createState() =>
      _CompanyViewMore_RealtimeScreenState();
}

class _CompanyViewMore_RealtimeScreenState
    extends State<CompanyViewMore_RealtimeScreen> {
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
    var dashboardListModel = Provider.of<Company_ViewMoreListViewModel>(context);
    Widget itemContainer = Container();
    switch (dashboardListModel.companyViewMoreItemList.status) {
      case Status.ERROR:
        _refreshComplete();
        break;
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        _refreshComplete();
        itemContainer = CompanyViewMore_RealtimeItemView(
          itemList: dashboardListModel.companyViewMoreItemList.status ==
              Status.COMPLETED
              ? dashboardListModel.companyViewMoreItemList.data
              .where((element) =>
          element.dashBoardBook.status == "1" &&
              element.dashBoardBook.is_you == "n")
              .toList()
              : [],
          title: "Realtime Booking",
          no_data: "No Booking Available",
        );
        break;
    }
    return Scaffold(
        appBar: AppBar(),
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
