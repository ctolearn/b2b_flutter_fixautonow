import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/screens/admin/AdminMainScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/CompanyMainScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/drawer/MainDrawerViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyUpdateInvoiceBookingScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/infoscreen/CompanyViewReceiveInfoScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/infoscreen/CompanyViewSentInfoScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/mainscreen/MainScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/services/ServiceAvailableScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/Signin/SignInViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_AddOnListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BranchUserListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_OutlierListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ProfileListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ReceiveListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_SentListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ServiceListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_UserListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_WorkTypeListenerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_AddOnListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_BranchListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_OutliersListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_ServiceListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/add_update/Company_AddUpdate_UsersListenerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_BookInformationViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyUpdateBookingScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/add_update/CompanyCreateBookingInvoiceScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/infoscreen/CompanyViewInvoiceScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookServiceListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookVehicleModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/book/Company_BookViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/screens/book/BookScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/services/ServicesAvailableListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_WorkTypeListModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/CountryDropdownListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/VehicleDropdownListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/OutlierTypeDropdownListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/AccountTypeDropdownListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/ImagePickListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/ActionsListener.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/rate/RateScreen.dart';
import 'model/ServiceImage.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_MessagesListViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/chat/ChatScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/invoice/InvoicePDFScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/employee/EmployeeMainScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_ViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/employee/Employee_JobViewModelList.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/infoscreen/CompanyViewDashboardBookInfo.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/info/Company_DashBoardBookInformationViewModelListener.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/search/Company_EmployeeListViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/search/CompanyEmployeeListScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/search/Company_SelectedEmployeeListener.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/dashboard/CompanyViewMore_UnAssignedScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/dashboard/CompanyViewMore_RealtimeScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/dashboard/CompanyViewMore_RequestedScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/dashboard/Company_ViewMoreListViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_ChatViewModelList.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String role = prefs.getString("current_role");
  String current_status = prefs.getString("current_status");
  String current_email = prefs.getString("current_email");
  String current_company = prefs.getString("current_company");
  String current_id = prefs.getString("current_id");
  CurrentUser user = new CurrentUser(
      current_role: role,
      current_status: current_status,
      current_email: current_email,
      current_company: current_company,
      current_id: current_id);
  Widget _homeScreen = MainScreen(
    currentUser: user,
  );

  if (prefs != null) {
    if (role == "/employee") {
      _homeScreen = EmployeeMainScreen();
    }
  }
  runApp(MyApp(
    homePage: _homeScreen,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget homePage;

  MyApp({this.homePage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => SignInViewModelListener()),
          //company
          ChangeNotifierProvider(create: (context) => MainDrawerViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_AddOnListViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_BranchListViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_OutlierListViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_ProfileListenerViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_ReceiveListViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_SentListViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_ServiceListViewModel()),
          ChangeNotifierProvider(
              create: (context) => Company_UsersListViewModel()),
          //company add update
          ChangeNotifierProvider(
            create: (context) => Company_AddUpdate_AddOnListenerViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => Company_AddUpdate_BranchListenerViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => Company_AddUpdate_OutliersListenerViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => Company_AddUpdate_ServiceListenerViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => Company_AddUpdate_UsersListenerViewModel(),
          ),
          //company view information

          ChangeNotifierProvider(
            create: (context) => Company_BookInformationViewModelListener(),
          ),
          //for book
          ChangeNotifierProvider(
            create: (context) => Company_BookViewModelListener(),
          ),
          ChangeNotifierProvider(
            create: (context) => Company_BookServiceListViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => Company_BookVehicleModelListener(),
          ),
          //services
          ChangeNotifierProvider(
            create: (context) => ServicesAvailableListViewModel(),
          ),
          //for branch list
          ChangeNotifierProvider(
            create: (context) => Company_BranchUsersListViewModel(),
          ),
          //for work type
          ChangeNotifierProvider(
            create: (context) => Company_WorkTypeListModel(),
          ),
          ChangeNotifierProvider(
              create: (context) =>
                  Company_AddUpdate_WorkTypeListenerViewModel()),
          //DROPDOWN
          ChangeNotifierProvider(
            create: (context) => CountryDropdownListener(),),
          //employee
          ChangeNotifierProvider(
            create: (context) => Employee_JobViewModelList(),),
          ChangeNotifierProvider(
            create: (context) => Employee_ViewModelListener(),),
          ChangeNotifierProvider(
            create: (context) => Company_DashBoardListModel(),),
          ChangeNotifierProvider(create: (context) =>
              Company_DashBoardBookInformationViewModelListener()),
          ChangeNotifierProvider(
            create: (context) => Company_EmployeeListViewModel(),),
          ChangeNotifierProvider(
            create: (context) => Company_SelectedEmployeeListener(),),
          ChangeNotifierProvider(create: (context) => Company_ViewMoreListViewModel(),),
          ChangeNotifierProvider(create: (context) => CountryDropdownListener(),),
          ChangeNotifierProvider(create: (context) => VehicleDropdownListener(),),
          ChangeNotifierProvider(create: (context) => AccountTypeDropdownListener(),),
          ChangeNotifierProvider(create: (context) => OutlierTypeDropdownListener(),),
          ChangeNotifierProvider(create: (context) => ImagePickListener(),),
          ChangeNotifierProvider(create: (context) => ActionsListener(),),
          ChangeNotifierProvider(create: (context) => Company_MessagesListViewModel(),),
          ChangeNotifierProvider(create: (context) => Company_ChatViewModelList(),),

        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: homePage,
          onGenerateRoute: (settings) {
            if (settings.name == "/company") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyMainScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/choose_employee") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyEmployeeListScreen(book_id: settings.arguments,),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) => child,);
            } else if (settings.name == "/home") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MainScreen(
                      currentUser: (settings.arguments != null ? settings
                          .arguments : null),),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/view_dashitem") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyViewDashboardBookInfo(book_id: settings.arguments,),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/employee") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    EmployeeMainScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/admin") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AdminMainScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/rate") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RateScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/invoice_pdf_view") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    InvoicePDFScreen(path: settings.arguments,),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/chat") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ChatScreen(mapData: settings.arguments,),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/main") {
              if (settings.arguments == null) {
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MainScreen(
                        currentUser: null,
                      ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) => child,
                );
              } else {
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MainScreen(
                        currentUser: settings.arguments,
                      ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) => child,
                );
              }
            } else if (settings.name == "/sentview") {
              Map<String, dynamic> mapObj =
              settings.arguments as Map<String, dynamic>;
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyViewSentInfoScreen(
                      book_id: mapObj["book_id"],
                      type: mapObj["type"],
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/receiveview") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyViewReceiveInfoScreen(
                      book_id: settings.arguments,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/updatereceivebooking") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyUpdateBookingScreen(
                      book_id: settings.arguments,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/createinvoice") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyCreateBookingInvoiceScreen(
                      book_id: settings.arguments,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/viewinvoice_receive") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyViewInvoiceScreen(
                      book_id: settings.arguments,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/viewinvoice_receive") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyViewInvoiceScreen(
                      book_id: settings.arguments,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/updateinvoice_receive") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyUpdateInvoiceBookingScreen(
                      book_id: settings.arguments,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              );
            } else if (settings.name == "/service_available") {
              var args = settings.arguments;
              if (args is ServiceImage) {
                return MaterialPageRoute(
                    builder: (_) =>
                        ServiceAvailableScreen(
                          service_image: args,
                        ));
              }
            } else if (settings.name == "/book") {
              var args = settings.arguments;

              if (args != null) {
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BookScreen(
                        service_id: args,
                      ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) => child,
                );
              } else {
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BookScreen(
                        service_id: null,
                      ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) => child,
                );
              }
            } else if (settings.name == "/viewmore_realtime") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyViewMore_RealtimeScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) => child,);
            } else if (settings.name == "/viewmore_requested") {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CompanyViewMore_RequestedScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) => child,);
            } else if (settings.name == "/viewmore_unassigned") {
              return PageRouteBuilder(pageBuilder: (context, animation,
                  secondaryAnimation) => CompanyViewMore_UnAssignedScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) => child,);
            }
            return MaterialPageRoute(
              builder: (context) => homePage,
            );
          },
        ));
  }
}
