import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardViewModel.dart';
import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'NotificationListItemView.dart';

class NotificationListScreen extends StatelessWidget {
  NotificationListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dashboardListModel = Provider.of<Company_DashBoardListModel>(context);
    Widget itemContainer = Container();

    switch (dashboardListModel.companyDashboardItemList.status) {
      case Status.LOADING:
        itemContainer = Center(child: CircularProgressIndicator());
        break;
      case Status.EMPTY:
        itemContainer = EmptyScreenResponse();
        break;
      case Status.COMPLETED:
        List<Company_DashBoardModel> itemList = dashboardListModel
            .companyDashboardItemList.data
            .where((element) =>
                element.dashBoardBook.status == "1" &&
                    element.dashBoardBook.is_you == "y" ||
                element.dashBoardBook.status == "1" &&
                    element.dashBoardBook.is_you == "n")
            .toList();
        itemContainer = ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return NotificationListItemView(dashboardModel:itemList[index]);
            });
        break;
      case Status.ERROR:
        itemContainer = ErrorScreenResponse();

        break;
    }
    return itemContainer;
  }
}
