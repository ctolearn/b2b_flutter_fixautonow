class Service_Category{
  String service_category_id;
  String service_name;
  Service_Category.fromJson(Map<String,dynamic> json):
      service_category_id = json["service_category_id"],
      service_name = json["service_name"];

}