
import 'package:flutter/cupertino.dart';
import 'package:b2b_flutter_fixautonow/enum/ActionType.dart';
import 'ActionModel.dart';
class ActionsListener extends ChangeNotifier {
  ActionModel actionModel;
  void toggle({ActionType actionType}) {
    if(actionModel == null){
      actionModel = new ActionModel(action: actionType,isOpen: actionModel == null ? true : !actionModel.isOpen);
    }else{
      if(actionModel.action == actionType){
        actionModel.isOpen = !actionModel.isOpen;

      }else{
        actionModel.action = actionType;
        actionModel.isOpen = true;
      }
    }
    this.actionModel = actionModel;
    notifyListeners();
  }
  void closeToggle(){
    actionModel = null;
    notifyListeners();
  }
}
