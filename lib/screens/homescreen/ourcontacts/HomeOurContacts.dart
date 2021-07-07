import 'package:flutter/material.dart';

class HomeOurContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/footer_bg.jpg'),
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
              "OUR",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text("CONTACTS",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Text("Address : 4578 Marmora Road, Glasgpow D04 89GR",
                style: TextStyle(color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/footer_contact.png'),
                        fit: BoxFit.fill,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Text("9876543210",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("9876543210",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ))
              ],
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                  "© 2020 B2B Booking Service. All Rights Reserved.Privacy Policy",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          ],
        )),
      ),
    );
  }
}
