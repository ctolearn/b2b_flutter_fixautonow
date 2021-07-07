class WorkType{
  String id;
  String service_category_id;
  String name;
  String description;
  bool selected;
  WorkType.fromJson(Map<String,dynamic> json):
      id = json["id"],
        service_category_id = json["service_category_id"],
        name = json["name"],
        description = json["description"],
        selected= json["selected"];

}