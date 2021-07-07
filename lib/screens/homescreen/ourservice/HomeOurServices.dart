import 'package:b2b_flutter_fixautonow/model/ServiceImage.dart';
import 'package:flutter/material.dart';


class HomeOurServices extends StatelessWidget {
  BuildContext buildContext;
  HomeOurServices({this.buildContext});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      // to disable GridView's scrolling
      shrinkWrap: true,
      // You won't see infinite size error
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      padding: const EdgeInsets.all(4.0),
      children: new List<Widget>.generate(serviceImageList.length, (index) {
        return new GridTile(
          child: new GestureDetector(
              onTap: () {
                Navigator.pushNamed(buildContext, '/service_available',
                    arguments: serviceImageList[index]);
              },
              child: Image.asset(serviceImageList[index].assetImage,
                  fit: BoxFit.fill)),
        );
      }),
    );
  }
}
