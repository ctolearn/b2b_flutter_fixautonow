import 'package:b2b_flutter_fixautonow/custom_ui/floating_button.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateBranchScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_AddOnListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_AddOnViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyBranchItemView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class CompanyBranchScreen extends StatefulWidget {
  CompanyBranchScreen({this.type});

  String type;

  @override
  _CompanyBranch_ScreenState createState() => _CompanyBranch_ScreenState();
}

class _CompanyBranch_ScreenState extends State<CompanyBranchScreen> implements MessageCallBack{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_BranchListViewModel>(context, listen: false)
        .fetchBranchList();
  }





  RefreshController _refreshController = RefreshController(initialRefresh: true);
  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_BranchListViewModel>(context, listen: false)
        .fetchBranchList();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_BranchListViewModel>(context, listen: false)
        .fetchBranchList();
  }

  void _refreshComplete() async{

    _refreshController.refreshCompleted(resetFooterState: true);

  }

  void _add(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CompanyAddUpdateBranchScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    List<Company_BranchViewModel> listModel = [];
    var branchList = Provider.of<Company_BranchListViewModel>(context);
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
            Company_BranchViewModel company_branchViewModel = listModel[index];
            return CompanyBranchItemView(company_branchViewModel: company_branchViewModel,userType: widget.type,messageCallBack: this,);
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

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
  }
}
/*   var branchListModel = Provider.of<Company_BranchListViewModel>(context);
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
                              CompanyAddUpdateBranch_Screen()),
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
                itemCount: branchListModel.branchViewListModel.length,
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
                                        branchListModel
                                            .branchViewListModel[index]
                                            .branch
                                            .address,
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
                                            widget.type == "admin"
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CompanyAddUpdateBranch_Screen(
                                                                  id: branchListModel
                                                                      .branchViewListModel[
                                                                          index]
                                                                      .branch
                                                                      .id,
                                                                )),
                                                      );
                                                    },
                                                    child: FaIcon(
                                                      FontAwesomeIcons.edit,
                                                      size: 15,
                                                      color: Colors.white,
                                                    )),
                                            widget.type == "admin"
                                                ? Container()
                                                : SizedBox(
                                                    width: 15,
                                                  ),
                                            widget.type == "admin"
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () => _showDialog(
                                                          context,
                                                          "delete",
                                                          branchListModel
                                                              .branchViewListModel[
                                                                  index]
                                                              .branch
                                                              .id,
                                                        ),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.trash,
                                                      size: 15,
                                                      color: Colors.white,
                                                    )),
                                            widget.type == "admin"
                                                ? Container()
                                                : SizedBox(
                                                    width: 15,
                                                  ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CompanyBranchUser_Screen(
                                                                company_id:
                                                                    branchListModel
                                                                        .branchViewListModel[
                                                                            index]
                                                                        .branch
                                                                        .id,
                                                              )));
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.users,
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
                                            "Email",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(branchListModel
                                              .branchViewListModel[index]
                                              .branch
                                              .email),
                                          Text(
                                            "Contact",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(branchListModel
                                              .branchViewListModel[index]
                                              .branch
                                              .contact),
                                          Text(
                                            "State",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(branchListModel
                                              .branchViewListModel[index]
                                              .branch
                                              .state),
                                          Text(
                                            "City",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(branchListModel
                                              .branchViewListModel[index]
                                              .branch
                                              .city),
                                          Text(
                                            "Country",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(branchListModel
                                              .branchViewListModel[index]
                                              .branch
                                              .country),
                                          Text(
                                            "Description",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(branchListModel
                                              .branchViewListModel[index]
                                              .branch
                                              .description),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ]))));
                })));
  }

  Company_BranchListViewModel company_branchListViewModel;

  void _showDialog(BuildContext context, String type, String id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var branchListModel =
              Provider.of<Company_BranchListViewModel>(context);
          this.company_branchListViewModel = branchListModel;
          var dialogModel = CustomDialogViewModel(type: type);
          return new WillPopScope(
              onWillPop: () async => false,
              child: CustomDialog(
                title: dialogModel.getTitle(),
                message: dialogModel.getMessage(),
                yesCallBack: branchListModel.status_delete == Status.LOADING
                    ? null
                    : callBackType(id, type),
                noCallBack: branchListModel.status_delete == Status.LOADING
                    ? null
                    : closeDialog,
              ));
        });
  }

  String itemId;

  VoidCallback callBackType(String id, String type) {
    this.itemId = id;
    if (type == "delete") {
      return deleteCallBack;
    }
  }

  void deleteCallBack() {
    company_branchListViewModel.deleteItem("");
    print(company_branchListViewModel.status_delete);
  }

  void closeDialog() {
    Navigator.of(context).pop();
  }*/
