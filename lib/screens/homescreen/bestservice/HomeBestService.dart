import 'package:b2b_flutter_fixautonow/extension_widget/Text.dart';
import 'package:flutter/material.dart';

class HomeBestService extends StatelessWidget {
  void readMore() {}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      print(constraint.maxWidth);
      Widget widget;
      if (constraint.maxWidth < 400) {
        widget = Column(
          children: [
            Container(
              //width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/best_service.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      // height: 300,
                      color: Colors.lightBlueAccent,
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "BEST",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "SERVICE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Car Repair can solve almost any problem that occurs with your vehicle. From engine repairs and oil change to regular maintenance and diagnostics, you will always get reliable services from our ASE certified technicians who use the latest in automotive equipmentand diagnostic software.",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: readMore,
                                child: Text("READ MORE"),
                              )
                            ],
                          ))),
                )
              ],
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/good_result.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      //height: 300,
                      color: Colors.lightBlueAccent,
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "100% RESULT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "GUARANTEE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Car Repair can solve almost any problem that occurs with your vehicle. From engine repairs and oil change to regular maintenance and diagnostics, you will always get reliable services from our ASE certified technicians who use the latest in automotive equipmentand diagnostic software.",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: readMore,
                                child: Text("READ MORE"),
                              )
                            ],
                          ))),
                ),
              ],
            ),
          ],
        );
      } else {
        widget = Column(
          children: [
            IntrinsicHeight(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                    // height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/best_service.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      // height: 300,
                      color: Colors.lightBlueAccent,
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "BEST",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "SERVICE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Car Repair can solve almost any problem that occurs with your vehicle. From engine repairs and oil change to regular maintenance and diagnostics, you will always get reliable services from our ASE certified technicians who use the latest in automotive equipmentand diagnostic software.",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: readMore,
                                child: Text("READ MORE"),
                              )
                            ],
                          ))),
                )
              ],
            )),
            IntrinsicHeight(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      //height: 300,
                      color: Colors.lightBlueAccent,
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "100% RESULT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "GUARANTEE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Car Repair can solve almost any problem that occurs with your vehicle. From engine repairs and oil change to regular maintenance and diagnostics, you will always get reliable services from our ASE certified technicians who use the latest in automotive equipmentand diagnostic software.",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: readMore,
                                child: Text("READ MORE"),
                              )
                            ],
                          ))),
                ),
                Expanded(
                  child: Container(
                    //height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/good_result.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  /*Container(
                width: MediaQuery.of(context).size.width,
                //height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/good_result.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
*/
                ),
              ],
            )),
          ],
        );
      }

      return widget;
    });
  }
}
