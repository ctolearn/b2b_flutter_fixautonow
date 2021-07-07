import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItem{
  String name;
  FaIcon faIcon;
  bool isLabel;
  int pos;
  DrawerItem({this.name,this.faIcon,this.isLabel,this.pos});
}
final List<DrawerItem> drawerItemList = [
  DrawerItem(name: "Dashboard",faIcon:FaIcon(FontAwesomeIcons.tachometerAlt,size: 18,),isLabel:false,pos: 0),
  DrawerItem(name: "MANAGE COMPANY",faIcon:null,isLabel:true),
  DrawerItem(name: "Profile",faIcon:FaIcon(FontAwesomeIcons.userCircle,size: 18,),isLabel:false,pos: 1),
  DrawerItem(name: "Branches",faIcon:FaIcon(FontAwesomeIcons.storeAlt,size: 18,),isLabel:false,pos: 2),
  DrawerItem(name: "Users",faIcon:FaIcon(FontAwesomeIcons.userFriends,size: 18,),isLabel:false,pos: 3),
  DrawerItem(name: "Outliers",faIcon:FaIcon(FontAwesomeIcons.storeAlt,size: 18,),isLabel:false,pos: 4),
  DrawerItem(name: "SERVICE OFFERED",faIcon:null,isLabel:true),
  DrawerItem(name: "Service",faIcon:FaIcon(FontAwesomeIcons.car,size: 18,),isLabel:false,pos: 5),
  DrawerItem(name: "Add On",faIcon:FaIcon(FontAwesomeIcons.puzzlePiece,size: 18,),isLabel:false,pos: 6),
  DrawerItem(name: "BOOKING",faIcon:null,isLabel:true),
  DrawerItem(name: "Receive Booking",faIcon:FaIcon(FontAwesomeIcons.calendarCheck,size: 18,),isLabel:false,pos: 7),
  DrawerItem(name: "Sent Booking",faIcon:FaIcon(FontAwesomeIcons.calendarCheck,size: 18,),isLabel:false,pos: 8),
  DrawerItem(name: "CONTROL",faIcon:null,isLabel:true),
  DrawerItem(name: "Logout",faIcon:FaIcon(FontAwesomeIcons.powerOff,size: 18,),isLabel:false,pos: 9),

];
final List<DrawerItem> employeeDrawerItemList = [
  DrawerItem(name: "Dashboard",faIcon:FaIcon(FontAwesomeIcons.tachometerAlt,size: 18,),isLabel:false,pos: 0),
  DrawerItem(name: "MANAGE ACCOUNT",faIcon:null,isLabel:true),
  DrawerItem(name: "Profile",faIcon:FaIcon(FontAwesomeIcons.userCircle,size: 18,),isLabel:false,pos: 1),
  DrawerItem(name: "JOB ORDER",faIcon:null,isLabel:true),
  DrawerItem(name: "Pending",faIcon:FaIcon(FontAwesomeIcons.briefcase,size: 18,),isLabel:false,pos: 2),
  DrawerItem(name: "Completed",faIcon:FaIcon(FontAwesomeIcons.briefcase,size: 18,),isLabel:false,pos: 3),
  DrawerItem(name: "CONTROL",faIcon:null,isLabel:true),
  DrawerItem(name: "Logout",faIcon:FaIcon(FontAwesomeIcons.powerOff,size: 18,),isLabel:false,pos: 4),

];