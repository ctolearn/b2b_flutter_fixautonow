import 'package:b2b_flutter_fixautonow/custom_ui/floating_button.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/book/BookScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ReceiveListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ReceiveViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyReceiveItemView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompanyReceiveScreen extends StatefulWidget {
  @override
  _CompanyReceive_ScreenState createState() => _CompanyReceive_ScreenState();
}

class _CompanyReceive_ScreenState extends State<CompanyReceiveScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_ReceiveListViewModel>(context, listen: false)
        .fetchReceiveBooking();
  }

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_ReceiveListViewModel>(context, listen: false)
        .fetchReceiveBooking();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_ReceiveListViewModel>(context, listen: false)
        .fetchReceiveBooking();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    List<Company_ReceiveViewModel> listModel = [];
    var branchList = Provider.of<Company_ReceiveListViewModel>(context);

    Widget containerWidget = Container();
    switch (branchList.apiResponse.status) {
      case Status.EMPTY:
        _refreshComplete();
        containerWidget = EmptyScreenResponse();
        break;
      case Status.LOADING:
        break;
      case Status.ERROR:
        _refreshComplete();
        containerWidget = ErrorScreenResponse();
        break;
      case Status.COMPLETED:
        _refreshComplete();
        listModel = branchList.apiResponse.data;
        containerWidget = ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (c, index) {
            return CompanyReceiveItemView(
              company_receiveViewModel: listModel[index],
            );
          },
          itemCount: listModel.length,
        );
        break;
    }
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPress: _add,
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

  void _add() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookScreen()),
    );
  }
}
/*  var receiveListModel = Provider.of<Company_ReceiveListViewModel>(context);
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: receiveListModel.companyReceiveListViewModel.length,
        itemBuilder: (context, index) {
          return ReceiveBooking_Item(
            company_receiveViewModel:
                receiveListModel.companyReceiveListViewModel[index],
            onClick: (data) {
              print(data);
              _showDialog(
                  context,
                  data,
                  receiveListModel.companyReceiveListViewModel[index]
                      .receiveBooking.booking_id);
            },
          );
        });
  }

  String itemId, actionType;
  Company_ReceiveListViewModel company_receiveListViewModel;

  void _showDialog(BuildContext context, String type, String id) {
    this.itemId = id;
    this.actionType = type;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var receiveListModel =
              Provider.of<Company_ReceiveListViewModel>(context);
          this.company_receiveListViewModel = receiveListModel;
          var dialogModel = CustomDialogViewModel(type: type);
          VoidCallback yesCallBack, noCallBack;

          switch (type) {
            case "delete":
              yesCallBack = receiveListModel.status_delete == Status.LOADING
                  ? null
                  : yesCallBack_;
              noCallBack = receiveListModel.status_delete == Status.LOADING
                  ? null
                  : closeDialog_;
              break;
            case "accept":
              break;
            case "accomplish":
              yesCallBack = receiveListModel.status_accomplish == Status.LOADING
                  ? null
                  : yesCallBack_;
              noCallBack = receiveListModel.status_accomplish == Status.LOADING
                  ? null
                  : closeDialog_;

              break;
            case "complete":
              yesCallBack = receiveListModel.status_complete == Status.LOADING
                  ? null
                  : yesCallBack_;
              noCallBack = receiveListModel.status_complete == Status.LOADING
                  ? null
                  : closeDialog_;

              break;
          }
          return new WillPopScope(
              onWillPop: () async => false,
          child:CustomDialog(
            title: dialogModel.getTitle(),
            message: dialogModel.getMessage(),
            yesCallBack: yesCallBack,
            noCallBack: noCallBack,
          ));
        });
  }

  void yesCallBack_() {
    switch (actionType) {
      case "delete":
        company_receiveListViewModel.declineBooking(itemId);
        break;
      case "accept":
        company_receiveListViewModel.declineBooking(itemId);
        break;
      case "accomplish":
        company_receiveListViewModel.declineBooking(itemId);

        break;
      case "complete":
        company_receiveListViewModel.completeBooking(itemId);
        break;
    }
  }

  void closeDialog_() {
    Navigator.of(context).pop();
  }*/
