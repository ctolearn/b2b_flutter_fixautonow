import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_WorkTypeListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompanyWorkTypesListScreen extends StatefulWidget {
  CompanyWorkTypesListScreen({this.service_id});

  String service_id;

  @override
  _CompanyWorkTypeList_ScreenState createState() =>
      _CompanyWorkTypeList_ScreenState();
}

class _CompanyWorkTypeList_ScreenState
    extends State<CompanyWorkTypesListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Company_WorkTypeListModel>(context, listen: false)
        .fetchWorkTypeList(widget.service_id);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_WorkTypeListModel>(context, listen: false)
        .fetchWorkTypeList(widget.service_id);
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_WorkTypeListModel>(context, listen: false)
        .fetchWorkTypeList(widget.service_id);
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  @override
  Widget build(BuildContext context) {
    var workList = Provider.of<Company_WorkTypeListModel>(context);
    Widget containerWidget = Container();
    switch (workList.workListModel.status) {
      case Status.COMPLETED:
        _refreshComplete();
        containerWidget = ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: workList.workListModel.data.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                  onPressed: () {
                    workList.selectedWorkType(index);
                  },
                  child: workList.workListModel.data[index].workType.selected
                      ? Text("Selected")
                      : Text("Select"));
            });
        break;
      case Status.EMPTY:
        _refreshComplete();
        containerWidget = EmptyScreenResponse();
        break;
      case Status.ERROR:
        _refreshComplete();
        containerWidget = ErrorScreenResponse();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Choose Work Types"),
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
}
