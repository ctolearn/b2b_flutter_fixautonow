import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookVehicleModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookViewModelListener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookVehicleMakeSelectScreen extends StatefulWidget {
  @override
  _BookVehicleMakeSelectScreenState createState() =>
      _BookVehicleMakeSelectScreenState();
}

class _BookVehicleMakeSelectScreenState
    extends State<BookVehicleMakeSelectScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Company_BookVehicleModelListener>(context, listen: false)
        .fetchVehicleModel();
  }


  void onRefresh() async {
    // monitor network fetch

    Provider.of<Company_BookVehicleModelListener>(context, listen: false)
        .fetchVehicleModel();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch

    Provider.of<Company_BookVehicleModelListener>(context, listen: false)
        .fetchVehicleModel();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    var bookSelectionModel =
        Provider.of<Company_BookVehicleModelListener>(context);
    Widget containerWidget = Container();
    switch (bookSelectionModel.fetchVehicleListResponse.status) {
      case Status.COMPLETED:
        _refreshComplete();
        containerWidget = ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount:bookSelectionModel.fetchVehicleListResponse.data.length,
            itemBuilder: (c, index) {
              return GestureDetector(
                child: Text(bookSelectionModel.fetchVehicleListResponse.data[index].make_title),
                onTap: () {
                  Provider.of<Company_BookViewModelListener>(context,listen: false).selectedModel(bookSelectionModel.fetchVehicleListResponse.data[index]);
                    Navigator.pop(context);

                },
              );
            });
        break;
      case Status.ERROR:
        _refreshComplete();
        containerWidget = ErrorScreenResponse();
        break;
      case Status.EMPTY:
        _refreshComplete();
        containerWidget = EmptyScreenResponse();
        break;
      case Status.LOADING:
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Vehicle"),
        centerTitle: true,
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
