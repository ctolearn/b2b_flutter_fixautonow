
import 'package:b2b_flutter_fixautonow/model/Service_Item.dart';
import 'package:flutter/cupertino.dart';

class ServicesAvailableViewModel{
  ServiceItem serviceItem;
  ServicesAvailableViewModel({ServiceItem serviceItem})
    : serviceItem = serviceItem;
  String get companyName => serviceItem.company_name;
  String get companyAddress => serviceItem.company_address;
  String get distance => serviceItem.distance;

}