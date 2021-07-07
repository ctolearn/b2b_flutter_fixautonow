class Outliers{
  String outlier_id;
  String outlier_type ;
  String parent_name ;
  String no_parent ;
  String no_parent_state ;
  String no_parent_city;
  String no_parent_country ;
  String no_parent_address ;
  Outliers();
  Outliers.fromJson(Map<String,dynamic> json):
    outlier_id =  json["outlier_id"],
    outlier_type = json["outlier_type"],
    parent_name = json["parent_name"],
    no_parent = json["no_parent"],
    no_parent_state = json["no_parent_state"],
    no_parent_city = json["no_parent_city"],
    no_parent_country = json["no_parent_country"],
    no_parent_address = json["no_parent_address"];

}