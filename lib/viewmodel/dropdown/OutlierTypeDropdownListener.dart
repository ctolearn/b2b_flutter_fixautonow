import 'package:flutter/cupertino.dart';

class OutlierTypeDropdownListener extends ChangeNotifier {

  List<String> outlierTypeList = <String>['White List', "Black List"];
  String outlier = "White List";

  void changeOutlier({String outlier}) {
    Future.delayed(Duration.zero, () {
      if(outlierTypeList.contains(outlier)){
        this.outlier = outlier;
      }else {
        this.outlier = outlierTypeList[0];
      }
      notifyListeners();
    });
  }
}
