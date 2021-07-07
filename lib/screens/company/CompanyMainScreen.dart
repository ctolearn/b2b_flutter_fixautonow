import 'package:b2b_flutter_fixautonow/custom_ui/notification_icon.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MainCompanyCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/model/DrawerItem.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyAddOnScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyBranchScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyDashboardScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyOutliersScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyProfileScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyReceiveScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanySentScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyServiceScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyUserScreen.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_MessagesListViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer/MainDrawerHeader.dart';
import 'drawer/MainDrawerItem.dart';
import 'drawer/MainDrawerViewModel.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/ActionsListener.dart';
import 'package:b2b_flutter_fixautonow/enum/ActionType.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/company/Company_DashBoardListViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/messages/MessageListScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/notification/NotificationListScreen.dart';

class CompanyMainScreen extends StatefulWidget {
  const CompanyMainScreen({Key key}) : super(key: key);

  @override
  _CompanyMainScreenState createState() => _CompanyMainScreenState();
}

class _CompanyMainScreenState extends State<CompanyMainScreen>
    implements MainCompanyCallBack {
  int selectedPos = 0;

  List<Widget> widgetList = [
    CompanyDashboadScreen(),
    CompanyProfileScreen(),
    CompanyBranchScreen(
      type: "company",
    ),
    CompanyUserScreen(),
    CompanyOutliersScreen(),
    CompanyServiceScreen(),
    CompanyAddOnScreen(),
    CompanyReceiveScreen(),
    CompanySentScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MainDrawerViewModel>(context, listen: false)
        .drawerSelected(0, 0);
    Provider.of<Company_DashBoardListModel>(context, listen: false)
        .fetchDashBoardCount();
    Provider.of<Company_MessagesListViewModel>(context,listen: false)
    .fetchMessageList();

  }

  @override
  Widget build(BuildContext context) {
    var dashboardListModel = Provider.of<Company_DashBoardListModel>(context);
    var drawerModel = Provider.of<MainDrawerViewModel>(context);
    selectedPos = drawerModel.position;
    List<Widget> navigationitems = [];
    for (int i = 0; i < drawerItemList.length; i++) {
      DrawerItem drawerItem = drawerItemList[i];
      if (drawerItem.isLabel) {
        navigationitems.add(Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              drawerItem.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
      } else {
        navigationitems.add(MainDrawerItem(
          isSelected: drawerModel.selected == i ? true : false,
          faiIcon: drawerItem.faIcon,
          name: drawerItem.name,
          onTapCallback: () {
            if (i == 13) {
              Navigator.of(context).pop();
              drawerModel.logOut(this);
            } else {
              Provider.of<ActionsListener>(context, listen: false)
                  .closeToggle();
              Navigator.of(context).pop();
              Provider.of<MainDrawerViewModel>(context, listen: false)
                  .drawerSelected(i, drawerItem.pos);
            }
          },
        ));
      }
    }
    /** notif listeners **/
    var actionListener = Provider.of<ActionsListener>(context);
    var messageListener = Provider.of<Company_MessagesListViewModel>(context);


    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Container(
              width: double.infinity,
              child: GestureDetector(
                  onTap: () {
                    Provider.of<ActionsListener>(context, listen: false)
                        .closeToggle();
                  },
                  child: AbsorbPointer(
                      child: CupertinoTextField(
                    placeholder: " Search Service",
                    enabled: false,
                  )))),
          actions: [
            Notification_Icon(
              faIcon: FaIcon(
                FontAwesomeIcons.bell,
                size: 18,
                color: Colors.white,
              ),
              count: dashboardListModel.notificationCount() == 0
                  ? ""
                  : dashboardListModel.notificationCount().toString(),
              onPressed: () {
                Provider.of<ActionsListener>(context, listen: false)
                    .toggle(actionType: ActionType.ORDER);
              },
            ),
            Notification_Icon(
              faIcon: FaIcon(
                FontAwesomeIcons.comment,
                size: 18,
                color: Colors.white,
              ),
              count: messageListener.messageCount() == 0 ? "" : messageListener.messageCount().toString(),
              onPressed: () {
                Provider.of<ActionsListener>(context, listen: false)
                    .toggle(actionType: ActionType.MESSAGE);
              },
            ),
            Notification_Icon(
              faIcon: FaIcon(
                FontAwesomeIcons.home,
                size: 18,
                color: Colors.white,
              ),
              count: "",
              onPressed: homePage,
            )
          ],
        ),
        body: Stack(children: [
          widgetList[
              //selectedPos <= (widgetList.length-1) ?
              selectedPos
              //    : 0
              ],
          actionListener.actionModel == null
              ? Container()
              : actionListener.actionModel.isOpen == true
                  ? Container(
                      child: actionListener.actionModel.action == ActionType.MESSAGE
                          ? MessageListScreen()
                          : NotificationListScreen(),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  : Container()
        ]),
        drawer: Drawer(
          child: ListView(
            children: [
              MainDrawerHeader(),
            ]..addAll(navigationitems),
          ),
        ));
  }

  void homePage() {
    Provider.of<ActionsListener>(context, listen: false).closeToggle();
    getCurrent().then((value) {
      if (value.current_role == null) {
        Navigator.pushReplacementNamed(context, "/home", arguments: null);
      } else {
        Navigator.pushReplacementNamed(context, "/home", arguments: value);
      }
    });
  }

  Future<CurrentUser> getCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String current_status = prefs.getString('current_status');
    String current_email = prefs.getString('current_email');
    String current_company = prefs.getString('current_company');
    String current_id = prefs.getString('current_id');
    String current_role = prefs.getString('current_role');
    var curr = CurrentUser(
        current_role: current_role,
        current_company: current_company,
        current_email: current_email,
        current_id: current_id,
        current_status: current_status);

    return curr;
  }

  @override
  void logOut() {
    // TODO: implement logOut
    Navigator.pushReplacementNamed(context, "/home");
  }
}
