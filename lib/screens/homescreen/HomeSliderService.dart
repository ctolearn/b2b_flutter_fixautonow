

import 'package:b2b_flutter_fixautonow/listener_utils/OnPageChange.dart';
import 'package:b2b_flutter_fixautonow/model/Slide.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/Slider/SliderModel_Listener.dart';
import 'package:flutter/material.dart';
import 'home_slider/SlideDots.dart';
import 'home_slider/SlideItem.dart';

class HomeSliderService extends StatelessWidget {
  PageController _pageController;
  int _currentPage;
  OnPageChange onPageChange;

  HomeSliderService(this._pageController, this._currentPage,this.sliderModel_Listener, {this.onPageChange});
  SliderModel_Listener sliderModel_Listener;
  final slideList = [
    Slide(
      imageUrl: 'assets/images/banner_1.jpg',
      title: 'A Cool Way to Get Start',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
    ),
    Slide(
      imageUrl: 'assets/images/banner_2.jpg',
      title: 'Design Interactive App UI',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
    ),
    Slide(
      imageUrl: 'assets/images/banner_1.jpg',
      title: 'It\'s Just the Beginning',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
    ),
  ];

  _onPageChanged(int index) {
    sliderModel_Listener.sliderSink.add(index);
    onPageChange.pos(index);
/*
    setState(() {
      _currentPage = index;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: slideList.length,
            itemBuilder: (ctx, i) => SlideItem(i),
          ),
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 18),
                child: StreamBuilder(
                  stream: sliderModel_Listener.sliderCurrentPosition,
                  builder: (c, snap) {
                    if (snap.hasData) {
                      _currentPage = snap.data;
                    }
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < slideList.length; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
