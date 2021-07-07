import 'package:b2b_flutter_fixautonow/custom_ui/floating_button.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_SentListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_SentViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanySentItemView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompanySentScreen extends StatefulWidget implements MessageCallBack{
  @override
  _CompanySent_ScreenState createState() => _CompanySent_ScreenState();

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
  }
}

class _CompanySent_ScreenState extends State<CompanySentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_SentListViewModel>(context, listen: false)
        .fetchSentBooking();
  }

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_SentListViewModel>(context, listen: false)
        .fetchSentBooking();
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_SentListViewModel>(context, listen: false)
        .fetchSentBooking();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    List<Company_SentViewModel> listModel = [];
    var branchList = Provider.of<Company_SentListViewModel>(context);
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
            return CompanySentItemView(
              company_sentViewModel: listModel[index],buildContext: context,
            );
          },
          itemCount: listModel.length,
        );

        break;
    }


    return Scaffold(
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
    /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CompanyAddUpdatAddOnScreen()),
      );*/
  }
}

/* var sentListViewModel = Provider.of<Company_SentListViewModel>(context);
    return SafeArea(
        child: Scaffold(
            floatingActionButton: SizedBox(
                width: 35,
                height: 35,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    Navigator.pushNamed(context, '/book', arguments: "Test");
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.plus,
                    size: 14,
                  ),
                  backgroundColor: Colors.blue,
                )),
            body: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: sentListViewModel.companySentListViewModel.length,
                itemBuilder: (context, index) {
                  return SentBooking_Item(
                    company_sentViewModel:
                        sentListViewModel.companySentListViewModel[index],
                    onClick: (data) {
                      print(data);
                      switch (data) {
                        case "check":
                          _showDialog(
                              context,
                              "accept",
                              sentListViewModel.companySentListViewModel[index]
                                  .sentBooking.booking_id);
                          break;
                        case "ban":
                          _showDialog(
                              context,
                              "delete",
                              sentListViewModel.companySentListViewModel[index]
                                  .sentBooking.booking_id);
                          break;
                        case "rate":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Rate_Screen()),
                          );
                          break;
                        case "no_invoice":
                          print("no invoice");
                          break;
                      }
                      //info
                      //check
                      //ban
                      //comment
                    },
                  );
                })));
  }

  String itemId;
  Company_SentListViewModel company_sentListViewModel;

  void _showDialog(BuildContext context, String type, String id) {
    this.itemId = id;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var sentListModel = Provider.of<Company_SentListViewModel>(context);
          this.company_sentListViewModel = sentListModel;
          var dialogModel = CustomDialogViewModel(type: type);
          return CustomDialog(
            title: dialogModel.getTitle(),
            message: dialogModel.getMessage(),
            yesCallBack: sentListModel.status_delete == Status.LOADING
                ? null
                : deleteCallBack,
            noCallBack: sentListModel.status_delete == Status.LOADING
                ? null
                : closeDialog,
          );
        });
  }

  void deleteCallBack() {

  }

  void closeDialog() {
    Navigator.of(context).pop();
  }*/
