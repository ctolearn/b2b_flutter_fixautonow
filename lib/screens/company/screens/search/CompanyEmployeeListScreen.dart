import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyUserItemView.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/search/Company_EmployeeListViewModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/itemview/CompanyEmployeeListItemView.dart';
class CompanyEmployeeListScreen extends StatefulWidget {
  String book_id;
  CompanyEmployeeListScreen({Key key,this.book_id}) : super(key: key);

  @override
  _CompanyEmployeeListScreenState createState() => _CompanyEmployeeListScreenState();
}

class _CompanyEmployeeListScreenState extends State<CompanyEmployeeListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_EmployeeListViewModel>(context,listen: false).fetchUsers();
  }


  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_EmployeeListViewModel>(context,listen: false).fetchUsers();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch

    Provider.of<Company_EmployeeListViewModel>(context,listen: false).fetchUsers();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    var employeeListModel =   Provider.of<Company_EmployeeListViewModel>(context);
    Widget containerWidget = Container();
    switch(employeeListModel.apiResponse.status){
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
      case Status.COMPLETED:
        _refreshComplete();
        var listModel = employeeListModel.apiResponse.data;
        containerWidget = ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (c, index) {
            return CompanyEmployeeListItemView(
              book_id: widget.book_id,
              company_userViewModel: listModel[index],
            );
          },
          itemCount: listModel.length,
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
        child: containerWidget,
      ),
    );
  }
}
