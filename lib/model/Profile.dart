class Profile{
  Profile();
  String company_name;
  String company_email;
  String company_country;
  String company_state;
  String company_city;
  String company_address;
  String company_contact;
  String company_c_code;
  String company_description;
  String company_photo;
  String owner_firstname;
  String owner_lastname;
  String owner_mobile;
  String owner_c_code;

  Profile.fromJson(Map<String,dynamic> json):
    company_name =  json["company_name"],
    company_email =  json["company_email"],
    company_country =  json["company_country"],
    company_state =  json["company_state"],
    company_city =  json["company_city"],
    company_address =  json["company_address"],
    company_contact =  json["company_contact"],
    company_c_code =  json["company_c_code"],
    company_description =  json["company_description"],
    company_photo =  json["company_photo"],
    owner_firstname =  json["owner_firstname"],
    owner_lastname =  json["owner_lastname"],
    owner_mobile =  json["owner_mobile"],
    owner_c_code =  json["owner_c_code"];
}