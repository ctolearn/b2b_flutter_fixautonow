import 'package:b2b_flutter_fixautonow/model/WorkType_Selection.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookServiceSelectScreen extends StatefulWidget {
  BookServiceSelectScreen({this.category_id});

  String category_id;

  @override
  _BookServiceSelectScreenState createState() =>
      _BookServiceSelectScreenState();
}

class _BookServiceSelectScreenState extends State<BookServiceSelectScreen> {
  @override
  Widget build(BuildContext context) {
    var bookWorkSelectionModel =
        Provider.of<Company_BookViewModelListener>(context);
    List<Company_BookViewModel> serviceListViewModel =
        bookWorkSelectionModel.fetchSelectionResponse.data;

    List<WorkType_Selection> workList = [];
    print("category id is : " + widget.category_id);
    for (int i = 0; i < serviceListViewModel.length; i++) {
      if (widget.category_id ==
          serviceListViewModel[i].book_workType_Selection.service_category_id) {
        workList =
            serviceListViewModel[i].book_workType_Selection.workTypeSelection;
      }
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: workList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            WorkType_Selection workSelect = workList[index];
            return GestureDetector(
              child: Text(workSelect.name),
              onTap: () => bookWorkSelectionModel.selectedService(workSelect),
            );
          }),
    );
  }
}
