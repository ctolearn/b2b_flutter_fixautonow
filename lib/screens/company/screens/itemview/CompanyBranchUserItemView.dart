import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchUsersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class CompanyWorkTypeItemView extends StatelessWidget {
  Company_BranchUsersViewModel company_branchUsersViewModel;
  CompanyWorkTypeItemView({this.company_branchUsersViewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: IntrinsicHeight(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              company_branchUsersViewModel.user.type,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(25.0),
                          )),
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompanyAddUpdateUser_Screen(
                                                          id: userListModel.fetchBranchUserList.data[
                                                                  index]
                                                              .user
                                                              .employee_id,
                                                        )),
                                              );*/
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.edit,
                                    size: 15,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                  onTap: () => null,
                                  child: FaIcon(
                                    FontAwesomeIcons.trash,
                                    size: 15,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ))),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(company_branchUsersViewModel.user.email),
                            Text(
                              "Firstname",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(company_branchUsersViewModel
                                .user
                                .firstname),
                            Text(
                              "Lastname",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(company_branchUsersViewModel
                                .user
                                .lastname),
                            Text(
                              "Mobile",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(company_branchUsersViewModel
                                .user
                                .mobile),
                          ],
                        ),
                      )),
                ],
              ),
            ])));
  }
}
