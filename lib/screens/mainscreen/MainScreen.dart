import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/screens/aboutscreen/AboutScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/faqscreen/FaqScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/homescreen/HomeScreen.dart';
import 'package:b2b_flutter_fixautonow/screens/signinscreen/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  CurrentUser currentUser;

  MainScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AboutScreen(),
    FaqScreen(),
    SignInScreen()
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      getCurrent().then((value) {
        if(value.current_role == null){
          setState(() {
            _currentIndex = index;
          });
        }else{
          Navigator.pushReplacementNamed(
              context, value.current_role).then((value) => _currentIndex = index);
        }
      });

    }else{
      setState(() {
        _currentIndex = index;
      });
    }
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


  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home,
      size: 18,), label: "Home"),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.infoCircle,
        size: 18), label: "About"),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidQuestionCircle,
        size: 18), label: "Faq"),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.tachometerAlt,
        size: 18), label: "About"),
  ];
  List<BottomNavigationBarItem> itemsDashboard = [
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home,
      size: 18,), label: "Home"),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.infoCircle,
        size: 18), label: "About"),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidQuestionCircle,
        size: 18), label: "Faq"),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.tachometerAlt,
        size: 18), label: "Dashboard"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: widget.currentUser == null ? items : itemsDashboard,
        unselectedItemColor: Colors.grey[500],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.grey[800],

        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        onTap: _onItemTapped,
      ),
    );
  }
}
