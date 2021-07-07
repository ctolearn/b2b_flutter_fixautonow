
import 'package:b2b_flutter_fixautonow/custom_ui/notification_icon.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MainCompanyCallBack.dart';
import 'package:b2b_flutter_fixautonow/screens/company/drawer/MainDrawerHeader.dart';
import 'package:b2b_flutter_fixautonow/screens/company/drawer/MainDrawerItem.dart';
import 'package:b2b_flutter_fixautonow/screens/company/drawer/MainDrawerViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:b2b_flutter_fixautonow/screens/employee/screens/EmployeeCompletedScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/employee/screens/EmployeePendingScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/employee/screens/EmployeeDashboardScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/employee/screens/EmployeeProfileScreen.dart';
import 'package:b2b_flutter_fixautonow/model/DrawerItem.dart';

class EmployeeMainScreen extends StatefulWidget {
  @override
  _EmployeeMainScreenState createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen>
    implements  MainCompanyCallBack {
  List<Widget> widgetList = [
    EmployeeDashboardScreen(),
    EmployeeProfileScreen(),
    EmployeePendingScreen(),
    EmployeeCompletedScreen()
  ];
  int selectedPos = 0;
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MainDrawerViewModel>(context, listen: false)
        .drawerSelected(0, 0);
    initPusher();
  }

  String lastConnectionState;
  Channel channel;

  Future<void> initPusher() async {
    await Pusher.init(
        "fd47d05b7bc7cf2d4b1c",
        PusherOptions(
          cluster: "ap1",
        ),
        enableLogging: true);

    Pusher.connect(onConnectionStateChange: (x) async {
      if (mounted)
        setState(() {
          lastConnectionState = x.currentState;
        });
    }, onError: (x) {
      debugPrint("Error: ${x.message}");
    });
    channel = await Pusher.subscribe('fixauto_chatroom_143');
    await channel.bind("chat-event", (x) {
      if (mounted) print("Data is : " + x.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerModel = Provider.of<MainDrawerViewModel>(context);
    selectedPos = drawerModel.position;
    List<Widget> navigationitems = [];
    for (int i = 0; i < employeeDrawerItemList.length; i++) {
      DrawerItem drawerItem = employeeDrawerItemList[i];
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
            if (i == 7) {
              Navigator.of(context).pop();
              drawerModel.logOut(this);
            } else {
              Navigator.of(context).pop();
              Provider.of<MainDrawerViewModel>(context, listen: false)
                  .drawerSelected(i, drawerItem.pos);
            }
/*            print(selectedPos.toString()+" is data");
            if(selectedPos == (9)){

            }else {
              Navigator.of(context).pop();
              Provider.of<MainDrawerViewModel>(context, listen: false)
                  .drawerSelected(i, drawerItem.pos);
            }*/
          },
        ));
      }
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(employeeDrawerItemList[drawerModel.selected].name),
              actions: [
                Notification_Icon(
                  faIcon: FaIcon(
                    FontAwesomeIcons.bell,
                    size: 18,
                    color: Colors.white,
                  ),
                  count: "",
                  onPressed: () {},
                ),
              ],
            ),
            body: widgetList[
            //selectedPos <= (widgetList.length-1) ?
            selectedPos
            //    : 0
            ],
            drawer: Drawer(
              child: ListView(
                children: [
                  MainDrawerHeader(),
                ]..addAll(navigationitems),
              ),
            )));

  }

  @override
  void logOut() {
    // TODO: implement logOut
    print("logout");
    //Navigator.of(context)
    //  .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    //Navigator.of(context).popUntil(ModalRoute.withName('/'));
    Navigator.pushReplacementNamed(context, "/home");
  }
}
