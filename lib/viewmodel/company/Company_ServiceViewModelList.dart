
import 'package:flutter/cupertino.dart';

class Company_ServiceCategoryViewModelList extends ChangeNotifier {
/*  Status status = Status.EMPTY;
  List<Company_ServiceCategoryViewModel> serviceCategoryViewModelList;

  void fetchServiceCategory() async {
    service_category = null;
    status = Status.LOADING;
    List<Service_Category> serviceCategoryList =
        await WebService().fetchServiceCategory();
    notifyListeners();
    this.serviceCategoryViewModelList = serviceCategoryList
        .map((e) => Company_ServiceCategoryViewModel(service_category: e))
        .toList();
    status = Status.COMPLETED;
    notifyListeners();
  }

  Service_Category service_category;

  void selectedCategory(String id) {
    for (int i = 0; i < serviceCategoryViewModelList.length; i++) {
      if (id ==
          serviceCategoryViewModelList[i]
              .service_category
              .service_category_id) {
        service_category = serviceCategoryViewModelList[i].service_category;
      }
    }
    notifyListeners();
  }*/
}
