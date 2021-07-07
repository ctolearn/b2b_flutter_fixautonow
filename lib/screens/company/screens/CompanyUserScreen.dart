import 'package:b2b_flutter_fixautonow/custom_ui/floating_button.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MessageCallBack.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateUserScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyUserItemView.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_UserListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompanyUserScreen extends StatefulWidget {
  @override
  _CompanyUser_ScreenState createState() => _CompanyUser_ScreenState();
}

class _CompanyUser_ScreenState extends State<CompanyUserScreen> implements MessageCallBack{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_UsersListViewModel>(context, listen: false)
        .fetchUsers();
  }

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_UsersListViewModel>(context, listen: false)
        .fetchUsers();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_UsersListViewModel>(context, listen: false)
        .fetchUsers();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    List<Company_UserViewModel> listModel = [];
    var userList = Provider.of<Company_UsersListViewModel>(context);

    Widget containerWidget = Container();
    switch (userList.apiResponse.status) {
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
        listModel = userList.apiResponse.data;
        containerWidget = ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (c, index) {
            return CompanyUserItemView(
              company_userViewModel: listModel[index],messageCallBack: this,
            );
          },
          itemCount: listModel.length,
        );

        break;
    }

    void _add() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CompanyAddUpdateUserScreen()),
      );
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
/* var userListModel = Provider.of<Company_UsersListViewModel>(context);
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
                          builder: (context) => CompanyAddUpdateUser_Screen()),
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
                itemCount: userListModel.userListViewModel.length,
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
                                        userListModel
                                            .userListViewModel[index].user.type,
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
                                                            CompanyAddUpdateUser_Screen(
                                                              id: userListModel
                                                                  .userListViewModel[
                                                                      index]
                                                                  .user
                                                                  .employee_id,
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
                                                    userListModel
                                                        .userListViewModel[
                                                            index]
                                                        .user
                                                        .employee_id),
                                                child: FaIcon(
                                                  FontAwesomeIcons.trash,
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
                                          Text(userListModel
                                              .userListViewModel[index]
                                              .user
                                              .email),
                                          Text(
                                            "Firstname",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(userListModel
                                              .userListViewModel[index]
                                              .user
                                              .firstname),
                                          Text(
                                            "Lastname",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(userListModel
                                              .userListViewModel[index]
                                              .user
                                              .lastname),
                                          Text(
                                            "Mobile",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(userListModel
                                              .userListViewModel[index]
                                              .user
                                              .mobile),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ]))));
                })));
  }

  String itemId;
  Company_UsersListViewModel company_usersListViewModel;

  void _showDialog(BuildContext context, String type, String id) {
    this.itemId = id;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var userListModel = Provider.of<Company_UsersListViewModel>(context);
          this.company_usersListViewModel = userListModel;
          var dialogModel = CustomDialogViewModel(type: type);
          return new WillPopScope(
              onWillPop: () async => false,
              child: CustomDialog(
                title: dialogModel.getTitle(),
                message: dialogModel.getMessage(),
                yesCallBack: userListModel.status_delete == Status.LOADING
                    ? null
                    : deleteCallBack,
                noCallBack: userListModel.status_delete == Status.LOADING
                    ? null
                    : closeDialog,
              ));
        });
  }

  void deleteCallBack() {}

  void closeDialog() {
    Navigator.of(context).pop();
  }*/
