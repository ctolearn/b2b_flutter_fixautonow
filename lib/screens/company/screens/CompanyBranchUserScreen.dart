import 'package:b2b_flutter_fixautonow/custom_ui/floating_button.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateUserScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchUserListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_UserListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/CustomDialogViewModel.dart';
import 'package:b2b_flutter_fixautonow/custom_dialog/Custom_Dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyBranchUserItemView.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddUpdateBranchUserScreen.dart';
class CompanyBranchUserScreen extends StatefulWidget {
  String company_id;

  CompanyBranchUserScreen({this.company_id});

  @override
  _CompanyBranchUserScreenState createState() =>
      _CompanyBranchUserScreenState();
}

class _CompanyBranchUserScreenState extends State<CompanyBranchUserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_BranchUsersListViewModel>(context, listen: false)
        .fetchBranchUsers(widget.company_id);
  }

  RefreshController _refreshController = RefreshController(initialRefresh: true);
  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_BranchUsersListViewModel>(context, listen: false)
        .fetchBranchUsers(widget.company_id);
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_BranchUsersListViewModel>(context, listen: false)
        .fetchBranchUsers(widget.company_id);
  }

  void _refreshComplete() async{

    _refreshController.refreshCompleted(resetFooterState: true);

  }


  @override
  Widget build(BuildContext context) {
    var userListModel = Provider.of<Company_BranchUsersListViewModel>(context);
    Widget containerWidget = Container();
    switch(userListModel.fetchBranchUserList.status){
      case Status.COMPLETED:
        _refreshComplete();
        containerWidget = ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: userListModel.fetchBranchUserList.data.length,
            itemBuilder: (context, index) {
              return CompanyWorkTypeItemView(company_branchUsersViewModel: userListModel.fetchBranchUserList.data[index],);
            });

        break;
      case Status.LOADING:
        break;
      case Status.ERROR:
        _refreshComplete();
        containerWidget = ErrorScreenResponse();
        break;
      case Status.EMPTY:

        _refreshComplete();
        containerWidget = EmptyScreenResponse();
        break;
    }

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingButton(onPress: (){
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => CompanyAddUpdateBranchUserScreen(company_id: widget.company_id,)));
      },),
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

  String itemId;

  void _showDialog(BuildContext context, String type, String id) {
    this.itemId = id;
    showDialog(
        context: context,
        builder: (context) {
          var userListModel = Provider.of<Company_BranchUsersListViewModel>(context);


          var dialogModel = CustomDialogViewModel(type: type);
          return CustomDialog(
            title: dialogModel.getTitle(),
            message: dialogModel.getMessage(),
            yesCallBack: userListModel.crudApiResponse.status == Status.LOADING
                ? null
                : deleteCallBack,
            noCallBack: userListModel.crudApiResponse.status == Status.LOADING
                ? null
                : closeDialog,
          );
        });
  }

  void deleteCallBack() {}

  void closeDialog() {
    Navigator.of(context).pop();
  }
}
