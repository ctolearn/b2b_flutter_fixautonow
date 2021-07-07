import 'package:b2b_flutter_fixautonow/listener_utils/MainCompanyCallBack.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MainDrawerViewModel extends ChangeNotifier {
  int selected = 0;
  int position = 0;

  Future<void> drawerSelected(int selected, int position) async {



      Future.delayed(Duration.zero, () async {
      pos(selected, position);
      notifyListeners();
      });

    }

  Future<void> pos(int selected, int position) async {
    this.position = position;
    this.selected = selected;
  }

  void logOut(MainCompanyCallBack callBack) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) => callBack.logOut());
  }
}
