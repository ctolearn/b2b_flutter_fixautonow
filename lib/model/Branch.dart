class Branch{
  String id;
  String email;
  String country;
  String state;
  String city;
  String address;
  String contact;
  String description;
  //
  String c_code;
  String parent_name;
  String name;
  Branch();
  Branch.fromJson(Map<String,dynamic> json) :
    id =  json["id"],
    email =  json["email"],
    country =  json["country"],
    state =  json["state"],
    city  = json["city"],
    address = json["address"],
    contact = json["contact"],
    description =  json["description"],
    c_code = json["c_code"],
    parent_name = json["parent_name"],
    name = json["name"];
}