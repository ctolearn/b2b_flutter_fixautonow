import 'package:b2b_flutter_fixautonow/custom_ui/floating_button.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyAddWorkTypeScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_WorkTypeListModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'itemview/CompanyWorkTypeItemView.dart';
class CompanyWorkTypeScreen extends StatefulWidget {
  CompanyWorkTypeScreen({this.service_id});

  String service_id;

  @override
  _CompanyWorkTypeScreenState createState() => _CompanyWorkTypeScreenState();
}

class _CompanyWorkTypeScreenState extends State<CompanyWorkTypeScreen> {
  String service_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.service_id = widget.service_id;

    Provider.of<Company_WorkTypeListModel>(context, listen: false)
        .fetchCompanyWorkTypeList(widget.service_id);
  }

  void onRefresh() async {
    // monitor network fetch

    Provider.of<Company_WorkTypeListModel>(context, listen: false)
        .fetchCompanyWorkTypeList(widget.service_id);
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch

    Provider.of<Company_WorkTypeListModel>(context, listen: false)
        .fetchCompanyWorkTypeList(widget.service_id);
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    var companyAddOnList = Provider.of<Company_WorkTypeListModel>(context);

    Widget containerWidget = Container();
    switch (companyAddOnList.fetchCompanyWorkType.status) {
      case Status.COMPLETED:
        _refreshComplete();
        containerWidget = ListView(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          children: [
            ListView.builder(
              itemCount: companyAddOnList.fetchCompanyWorkType.data.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return CompanyWorkTypeItemView(company_companyWorkTypeModel: companyAddOnList.fetchCompanyWorkType.data[index],service_id: widget.service_id,);
              },
            ),
            //ElevatedButton(onPressed: () {}, child: Text("Save Work Type"))
          ],
        );
        break;
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
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Work Types"),
      ),
      floatingActionButton: FloatingButton(
        onPress: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompanyAddWorkType_Screen(service_id)),
          );
        },
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
