
import 'WorkType_Selection.dart';

class Book_WorkType_Selection{
  String service_category_id;
  String service_name;
  String category_type_name;
  String category_type_description;
  String category_type_id;
  List<WorkType_Selection> workTypeSelection;
  Book_WorkType_Selection.fromJson(Map<String,dynamic> json):
        service_category_id = json["service_category_id"],
        service_name = json["service_name"],
        category_type_name = json["category_type_name"],
        category_type_description = json["category_type_description"],
        category_type_id = json["category_type_id"],
        workTypeSelection = (json['data'] as Iterable).map((item) => WorkType_Selection.fromJson(item)).toList();
}