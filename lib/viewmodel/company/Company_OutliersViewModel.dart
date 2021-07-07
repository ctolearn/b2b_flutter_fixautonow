import 'package:b2b_flutter_fixautonow/model/Outliers.dart';

class Company_OutliersViewModel{
  Outliers outliers;
  Company_OutliersViewModel({this.outliers});

  String get companyName => outliers.no_parent.isEmpty
      ? outliers.parent_name +
      " " +
      outliers.no_parent_address +
      " " +
      outliers.no_parent_city
      : outliers.no_parent;
}