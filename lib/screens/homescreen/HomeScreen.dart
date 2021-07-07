import 'dart:async';

import 'package:b2b_flutter_fixautonow/listener_utils/OnPageChange.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/Slider/SliderModel_Listener.dart';
import 'package:flutter/material.dart';

import 'HomeSliderService.dart';
import 'aboutus/HomeAboutUs.dart';
import 'bestservice/HomeBestService.dart';
import 'bookingservice/HomeBookingService.dart';
import 'ourcontacts/HomeOurContacts.dart';
import 'ourservice/HomeOurServices.dart';

class HomeScreen extends StatefulWidget {
  BuildContext buildContext;
  HomeScreen({Key key,this.buildContext}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements OnPageChange {
  Timer _timer;
  int _currentPage = 0;
  var _sliderModelListener = SliderModel_Listener();
  var _pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: ListView(
            shrinkWrap: true,
            children: [
              HomeSliderService(

                _pageController,
                _currentPage,
                _sliderModelListener,
                onPageChange: this,
              ),
              HomeAboutUs(),
              HomeBookingService(buildContext: context,),
              HomeOurServices(buildContext: context),
              HomeBestService(),
              HomeOurContacts(),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = new Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  @override
  pos(int pos) {
    // TODO: implement pos
    _currentPage = pos;
  }
}
