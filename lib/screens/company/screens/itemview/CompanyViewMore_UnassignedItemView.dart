import 'package:b2b_flutter_fixautonow/custom_ui/circular_textfield.dart';
import 'package:b2b_flutter_fixautonow/enum/DecorationSize.dart';
import 'package:b2b_flutter_fixautonow/enum/Status.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/dashboarditem_button.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/search/Company_SelectedEmployeeListener.dart';
import 'package:b2b_flutter_fixautonow/custom_ui/viewmore_button.dart';

class CompanyViewMore_UnassignedItemView extends StatelessWidget {
  Company_DashBoardModel company_dashBoardModel;

  CompanyViewMore_UnassignedItemView({this.company_dashBoardModel});

  TextEditingController employeeTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var employeeSelectedModel =
        Provider.of<Company_SelectedEmployeeListener>(context);
    if (employeeSelectedModel.userItem != null) {
      if (employeeSelectedModel.userItem.book_id ==
          company_dashBoardModel.dashBoardBook.book_id) {
        employeeTextController.text =
            employeeSelectedModel.userItem.user.firstname;
      }else{
        employeeTextController.clear();

      }
    }

    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: PhysicalModel(
            elevation: 6.0,
            shape: BoxShape.rectangle,
            shadowColor: Colors.black54,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Car Model : " +
                            company_dashBoardModel.dashBoardBook.vehicle_model)
                        .boldText()
                        .blackColor(),
                    Text("Car Type : " +
                            company_dashBoardModel.dashBoardBook.vehicle_type)
                        .boldText()
                        .blackColor(),
                    Text("Car Make : ").boldText().blackColor(),
                    Text("Requested By : " +
                            company_dashBoardModel.dashBoardBook.company_name)
                        .boldText()
                        .blackColor(),
                    Text("Location : " +
                            company_dashBoardModel
                                .dashBoardBook.company_address)
                        .boldText()
                        .blackColor(),
                    Text("Distance : " +
                            company_dashBoardModel.dashBoardBook.distance
                                .toString())
                        .boldText()
                        .blackColor(),
                    Text("Scheduled : " +
                            company_dashBoardModel.dashBoardBook.date +
                            " " +
                            company_dashBoardModel.dashBoardBook.time)
                        .boldText()
                        .blackColor(),
                    Text("Assign Employee").blackColor().boldText(),
                    CircularTextField(
                      onTap: () {
                        Navigator.of(context).pushNamed("/choose_employee",
                            arguments:
                                company_dashBoardModel.dashBoardBook.book_id);
                      },
                      controller: employeeTextController,
                      descorationSize: DecorationSize.SMALL,
                      isEnabled: false,
                      hintText: "Choose Employee",
                      color: Colors.white,
                    ),
                  ],
                ))));
  }
}
