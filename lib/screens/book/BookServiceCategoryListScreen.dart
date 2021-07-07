import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/model/Book_WorkType_Selection.dart';
import 'package:b2b_flutter_fixautonow/screens/response/EmptyScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/screens/response/ErrorScreenResponse.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookViewModelListener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookServiceCategoryListScreen extends StatefulWidget {
  @override
  _BookServiceCategoryListScreenState createState() =>
      _BookServiceCategoryListScreenState();
}

class _BookServiceCategoryListScreenState
    extends State<BookServiceCategoryListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Company_BookViewModelListener>(context, listen: false)
        .fetchSelection();
  }

  void onRefresh() async {
    // monitor network fetch
    Provider.of<Company_BookViewModelListener>(context, listen: false)
        .fetchSelection();
    // if failed,use refreshFailed()
  }

  void _onLoading() {
    // monitor network fetch
    Provider.of<Company_BookViewModelListener>(context, listen: false)
        .fetchSelection();
  }

  void _refreshComplete() async {
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    var serviceCategory = Provider.of<Company_BookViewModelListener>(context);
    Widget containerWidget = Container();
    switch (serviceCategory.fetchSelectionResponse.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        _refreshComplete();
        containerWidget = ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: serviceCategory.fetchSelectionResponse.data.length,
          itemBuilder: (context, index) {
            Book_WorkType_Selection workType_Selection = serviceCategory
                .fetchSelectionResponse.data[index].book_workType_Selection;
            return Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Text(workType_Selection.service_name),
                  onTap: () {
                    serviceCategory.selectedCategory(
                        workType_Selection.service_category_id);
                    Navigator.pop(context);
                  },
                ));
          },
          shrinkWrap: true,
        );
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
    return Scaffold(appBar: AppBar(), body: widget);
  }
}
