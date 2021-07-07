import 'package:flutter/material.dart';

class HomeAboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: HexColor("#2377b2"),
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
            bottom: 16,
          ),
          child: Container(
              child: Column(
            children: [
              Text(
                "A FEW WORDS",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text("ABOUT US",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              SizedBox(
                height: 5,
              ),
              Text(
                  "When it comes to auto repair, most businesses employ a quick method to determining the source of a problem. This can lead to unneeded and costly remedies that don't even address the root of the problem, or possibly worsen the situation.\n\n When it comes to maintaining your vehicle, our professional and licensed auto mechanics Shop at fixautonow use the best approach: we get straight to the source of the problem. We refer you to the best vehicle repair business we can find, and we fix it correctly, saving you time and money.",
                  style: TextStyle(color: Colors.white, fontSize: 14),textAlign: TextAlign.center,),
              ElevatedButton(
                  onPressed: () => print(""), child: Text("READ MORE"))
            ],
          )),
        ));
  }
}
