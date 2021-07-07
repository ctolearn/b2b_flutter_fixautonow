import 'package:b2b_flutter_fixautonow/model/CurrentUser.dart';
import 'package:b2b_flutter_fixautonow/screens/book/BookScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBookingService extends StatelessWidget {
  BuildContext buildContext;
  HomeBookingService({this.buildContext});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/booking_service_bg.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          top: 30,
          right: 16,
          bottom: 30,
        ),
        child: Container(
            child: Column(
          children: [
            Text(
              "B2B AUTOMOTIVE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text("BOOKING SERVICE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder:(context)=>SearchService(logIn_View)));
                },
                child: TextField(
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      enabled: false,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Search for service",
                      fillColor: Colors.white),
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  getCurrent().then((value) {
                    if(value.current_role == null){
                /*      setState(() {
                        _currentIndex = index;
                      });*/
                    }else{


                      Navigator.push(
                        buildContext,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookScreen()),
                      );

                    }
                  });

                },
                child: Text("Book Now",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          ],
        )),
      ),
    );
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

}
