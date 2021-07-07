class Company {
  String company_id;
  String parent_name;
  String parent_state;
  String parent_city;
  String parent_address;
  String parent_country;
  String no_parent;
  String no_parent_country;
  String no_parent_address;
  Company();

  Company.fromJson(Map<String, dynamic> json)
      : company_id = json["company_id"],
        parent_name = json["parent_name"],
        parent_state = json["parent_state"],
        parent_city = json["parent_city"],
        parent_address = json["parent_address"],
        parent_country = json["parent_country"],
        no_parent = json["no_parent"],
        no_parent_country = json["no_parent_country"],
        no_parent_address = json["no_parent_address"];
}
