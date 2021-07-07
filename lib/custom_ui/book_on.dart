import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookServiceListViewModel.dart';

class Book_On extends StatelessWidget {
  String service_id;

  Book_On({this.service_id});

  @override
  Widget build(BuildContext context) {
    //for realtime


    var bookWorkSelectionModel =
    Provider.of<Company_BookViewModelListener>(context);
    var bookSelectedService =
        Provider.of<Company_BookServiceListViewModel>(context);

    return Container(
        margin: EdgeInsets.only(left: 5),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Text(
              "",
              style: TextStyle(fontSize: 12),
            )
          ]..addAll(service_id == null
              ? List.generate(
                  bookWorkSelectionModel.selected_bookWorkType.length,
                  (index) => Padding(
                      padding: EdgeInsets.all(5),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(bookWorkSelectionModel
                                              .selected_bookWorkType[index]
                                              .name)
                                          .whiteColor()
                                          .boldText())),
                              GestureDetector(
                                  onTap: () => bookWorkSelectionModel
                                      .removeSelected(bookWorkSelectionModel
                                          .selected_bookWorkType[index]),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(" x ")
                                                .whiteColor()
                                                .boldText())),
                                  ))
                            ])),
                      )),
                )
              : List.generate(
                  bookSelectedService.selected_companyWorkTypeList.length,
                  (index) => Padding(
                      padding: EdgeInsets.all(5),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(bookSelectedService
                                              .selected_companyWorkTypeList[
                                                  index]
                                              .type_name)
                                          .whiteColor()
                                          .boldText())),
                              GestureDetector(
                                  onTap: () => bookSelectedService
                                      .removeSelected(bookSelectedService
                                          .selected_companyWorkTypeList[index]),
                                  child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: DecoratedBox(
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(" x ")
                                                  .whiteColor()
                                                  .boldText()))))
                            ])),
                      )),
                )),
        ));
  }
}
