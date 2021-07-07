import 'dart:convert';
import 'package:b2b_flutter_fixautonow/model/Company_WorkType.dart';
import 'package:b2b_flutter_fixautonow/model/Service.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookServiceListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookServiceDataSelectScreen extends StatefulWidget {
  @override
  _BookServiceDataSelectScreenState createState() =>
      _BookServiceDataSelectScreenState();
}

class _BookServiceDataSelectScreenState
    extends State<BookServiceDataSelectScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // parseData();
  }

  @override
  Widget build(BuildContext context) {
    var bookSelectedService =
        Provider.of<Company_BookServiceListViewModel>(context);
    Service service = bookSelectedService.service;
    List<Company_WorkType> companyWorkList = service.companyWorkTypeList;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: companyWorkList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Company_WorkType company_workType = companyWorkList[index];
            return GestureDetector(
              child: Text(company_workType.type_name),
              onTap: () =>
                  bookSelectedService.selectedService(company_workType),
            );

            return Text(company_workType.type_name);
          }),
    );
  }
}
