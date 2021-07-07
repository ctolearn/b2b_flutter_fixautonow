import 'package:b2b_flutter_fixautonow/custom_ui/floating_button.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'add_update/CompanyAddUpdateServiceScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyServiceItemView.dart';

class CompanyServiceScreen extends StatefulWidget {
  @override
  _CompanyService_ScreenState createState() => _CompanyService_ScreenState();
}

class _CompanyService_ScreenState extends State<CompanyServiceScreen> implements MessageCallBack {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_ServiceListViewModel>(context, listen: false)
        .fetchServiceList();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_ServiceListViewModel>(context, listen: false)
        .fetchServiceList();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_ServiceListViewModel>(context, listen: false)
        .fetchServiceList();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    List<Company_ServiceViewModel> listModel = [];
    var branchList = Provider.of<Company_ServiceListViewModel>(context);
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
            return CompanyServiceItemView(
              company_serviceViewModel: listModel[index],messageCallBack: this,
            );
          },
          itemCount: listModel.length,
        );

        break;
    }



    return Scaffold(
      floatingActionButton: FloatingButton(onPress: _add,),
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
      MaterialPageRoute(
          builder: (context) => CompanyAddUpdateServiceScreen()),
    );
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ));
    });
  }
}
/*  var serviceListModel = Provider.of<Company_ServiceListViewModel>(context);
    return SafeArea(
        child: Scaffold(
            floatingActionButton: SizedBox(
                width: 35,
                height: 35,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CompanyAddUpdateService_Screen()),
                    );
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.plus,
                    size: 14,
                  ),
                  backgroundColor: Colors.blue,
                )),
            body: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: serviceListModel.serviceListViewModel.length,
                itemBuilder: (context, index) {
                  return PhysicalModel(
                      elevation: 6.0,
                      shape: BoxShape.rectangle,
                      shadowColor: Colors.black54,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      child: Card(
                          elevation: 0,
                          child: IntrinsicHeight(
                              child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    child: Container(
                                        child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        serviceListModel
                                            .serviceListViewModel[index]
                                            .service
                                            .service_name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(25.0),
                                        )),
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CompanyAddUpdateService_Screen(
                                                              id: serviceListModel
                                                                  .serviceListViewModel[
                                                                      index]
                                                                  .service
                                                                  .service_id,
                                                            )),
                                                  );
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.edit,
                                                  size: 15,
                                                  color: Colors.white,
                                                )),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                                onTap: () => _showDialog(
                                                    context,
                                                    "delete",
                                                    serviceListModel
                                                        .serviceListViewModel[
                                                            index]
                                                        .service
                                                        .service_id),
                                                child: FaIcon(
                                                  FontAwesomeIcons.trash,
                                                  size: 15,
                                                  color: Colors.white,
                                                )),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  //CompanyWorkType_Screen
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CompanyWorkType_Screen(
                                                              service_id:
                                                                  serviceListModel
                                                                      .serviceListViewModel[
                                                                          index]
                                                                      .service
                                                                      .service_id,
                                                            )),
                                                  );
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.cogs,
                                                  size: 15,
                                                  color: Colors.white,
                                                )),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ))),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, bottom: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Service Category",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(serviceListModel
                                              .serviceListViewModel[index]
                                              .service
                                              .service_category_name),
                                          Text(
                                            "Open Time",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(serviceListModel
                                              .serviceListViewModel[index]
                                              .service
                                              .service_start),
                                          Text(
                                            "Close Time",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(serviceListModel
                                              .serviceListViewModel[index]
                                              .service
                                              .service_end),
                                          Text(
                                            "Approx. Duration",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(serviceListModel
                                              .serviceListViewModel[index]
                                              .service
                                              .service_approximate),
                                          Text(
                                            "Description",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(serviceListModel
                                              .serviceListViewModel[index]
                                              .service
                                              .service_description),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ]))));
                })));
  }

  String itemId;
  Company_ServiceListViewModel company_serviceListViewModel;

  void _showDialog(BuildContext context, String type, String id) {
    this.itemId = id;
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          var serviceListModel =
              Provider.of<Company_ServiceListViewModel>(context);
          this.company_serviceListViewModel = serviceListModel;
          var dialogModel = CustomDialogViewModel(type: type);
          return new WillPopScope(
              onWillPop: () async => false,
          child:CustomDialog(
            title: dialogModel.getTitle(),
            message: dialogModel.getMessage(),
            yesCallBack: serviceListModel.status_delete == Status.LOADING
                ? null
                : deleteCallBack,
            noCallBack: serviceListModel.status_delete == Status.LOADING
                ? null
                : closeDialog,
          ));
        });
  }

  void deleteCallBack() {}

  void closeDialog() {
    Navigator.of(context).pop();
  }*/
