import 'package:b2b_flutter_fixautonow/custom_ui/notification_icon.dart';
import 'package:b2b_flutter_fixautonow/listener_utils/MainCompanyCallBack.dart';
import 'package:b2b_flutter_fixautonow/model/DrawerItem.dart';
import 'package:b2b_flutter_fixautonow/screens/company/drawer/MainDrawerHeader.dart';
import 'package:b2b_flutter_fixautonow/screens/company/drawer/MainDrawerItem.dart';
import 'package:b2b_flutter_fixautonow/screens/company/drawer/MainDrawerViewModel.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyAddOnScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyBranchScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyOutliersScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyProfileScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyReceiveScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanySentScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyServiceScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyUserScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/screens/company/screens/CompanyDashboardScreen.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'screens/AdminProfileScreen.dart';
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> implements MainCompanyCallBack{
  List<Widget> widgetList = [
    CompanyDashboadScreen(),
    AdminProfileScreen(),
    CompanyBranchScreen(
      type: "admin",
    ),
    CompanyUserScreen(),
    CompanyOutliersScreen(),
    CompanyServiceScreen(),
    CompanyAddOnScreen(),
    CompanyReceiveScreen(),
    CompanySentScreen()
  ];

  String lastConnectionState;
  Channel channel;
  int selectedPos = 0;

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
              title: Container(
                  width: double.infinity,
                  child: CupertinoTextField(
                    placeholder: " Search Service",
                    enabled: false,
                  )),
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
                Notification_Icon(
                  faIcon: FaIcon(
                    FontAwesomeIcons.comment,
                    size: 18,
                    color: Colors.white,
                  ),
                  count: "",
                  onPressed: () {},
                ),
                Notification_Icon(
                  faIcon: FaIcon(
                    FontAwesomeIcons.home,
                    size: 18,
                    color: Colors.white,
                  ),
                  count: "",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/home",
                        arguments: "/company");
                  },
                )
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
