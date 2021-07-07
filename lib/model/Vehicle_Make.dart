class Vehicle_Make{
  String make_id;
  String make_code;
  String make_title;
  Vehicle_Make.fromJson(Map<String,dynamic> json):
     make_code = json["make_code"],
        make_id = json["make_id"],
        make_title = json["make_title"];
}