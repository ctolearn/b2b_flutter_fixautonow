import 'dart:async';
import 'Slider_Model.dart';
class SliderModel_Listener implements Slider_Model {
  StreamController<int> streamController = StreamController.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
  }

  @override
  // TODO: implement sliderController
  Sink get sliderSink => streamController;

  @override
  // TODO: implement sliderCurrentPosition
  Stream<int> get sliderCurrentPosition => streamController.stream;
}
