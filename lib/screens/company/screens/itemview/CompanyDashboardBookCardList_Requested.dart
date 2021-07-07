import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dashboarditem_button.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/search/Company_SelectedEmployeeListener.dart';

import 'package:b2b_flutter_fixautonow/custom_ui/viewmore_button.dart';

class CompanyDashboardBookCardList_Requested extends StatelessWidget {
  String title, no_data;
  List<Company_DashBoardModel> itemList;

  CompanyDashboardBookCardList_Requested(
      {this.title, this.no_data, this.itemList});

  List<TextEditingController> controllerList = [];

  @override
  Widget build(BuildContext context) {
    Widget itemContainer, rowButtonType = Container();

    var dashboardListModel = Provider.of<Company_DashBoardListModel>(context);
    switch (dashboardListModel.companyDashboardItemList.status) {
      case Status.EMPTY:
        itemContainer = Column(children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: Center(child: Text(no_data))),
          Padding(
              padding: const EdgeInsets.all(5),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ))
        ]);
        break;
      case Status.COMPLETED:
        itemContainer = itemList.length == 0
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Center(child: Text(no_data).boldText().blackColor()))
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemList.length <= 3? itemList.length : 3 ,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Car Model : " +
                              itemList[index].dashBoardBook.vehicle_model)
                          .boldText()
                          .blackColor(),
                      Text("Car Type : " +
                              itemList[index].dashBoardBook.vehicle_type)
                          .boldText()
                          .blackColor(),
                      Text("Car Make : "+itemList[index].dashBoardBook.vehicle_make).boldText().blackColor(),
                      Text("Requested By : " +
                              itemList[index].dashBoardBook.company_name)
                          .boldText()
                          .blackColor(),
                      Text("Location : " +
                              itemList[index].dashBoardBook.company_address)
                          .boldText()
                          .blackColor(),
                      Text("Distance : " +
                              itemList[index].dashBoardBook.distance.toString())
                          .boldText()
                          .blackColor(),
                      Text("Scheduled : " +
                              itemList[index].dashBoardBook.date +
                              " " +
                              itemList[index].dashBoardBook.time)
                          .boldText()
                          .blackColor(),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 5, right: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DashboardItem_Button(
                                button_title: "Accept",
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              DashboardItem_Button(
                                button_title: "Decline",
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              DashboardItem_Button(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      "/view_dashitem",
                                      arguments: itemList[index]
                                          .dashBoardBook
                                          .book_id);
                                },
                                button_title: "View Details",
                              )
                            ],
                          )),
                      (itemList.length - 1 == index)
                          ? (itemList.length == 3
                              ? ViewMore_Button(
                                  onTap:(){
                                    Navigator.of(context).pushNamed("/viewmore_requested");
                                  },
                                  title: "View more requested",
                                )
                              : Container())
                          : Padding(
                              padding: const EdgeInsets.all(5),
                              child: Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            )
                    ],
                  );
                });
        break;
      case Status.LOADING:
        itemContainer = Column(children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CircularProgressIndicator()))
        ]);
        break;
      default:
        itemContainer = Column(children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CircularProgressIndicator()))
        ]);
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
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                    color: Colors.grey,
                    width: double.maxFinite,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ))),
                itemContainer
              ],
            )));
  }
}
