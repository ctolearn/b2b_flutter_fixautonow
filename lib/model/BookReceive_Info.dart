import 'Vehicle_URL.dart';

class BookReceive_Info{
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
  String vehicle_type;
  String vehicle_make;
  String vehicle_year;
  String vin;
  String vehicle_model;
  String remarks;
  String category_name;
  String service_name;
  String booking_id;
  String service_due;
  List<dynamic> service_types;
  String service_price;
  List<Vehicle_URL> urls;
  BookReceive_Info.fromJson(Map<String,dynamic> json):
    company_name = json["company_name"],
    company_email = json["company_email"],
    company_country = json["company_country"],
    company_state = json["company_state"],
    company_city = json["company_city"],
    company_address = json["company_address"],
    company_contact = json["company_contact"],
    company_c_code = json["company_c_code"],
    company_description = json["company_description"],

    company_photo = json["company_photo"],
    vehicle_type = json["vehicle_type"],
    vehicle_make = json["vehicle_make"],
    vehicle_year = json["vehicle_year"],
    vin = json["vin"],
    vehicle_model = json["vehicle_model"],
    remarks = json["remarks"],
    category_name = json["category_name"],
    service_name = json["service_name"],
    booking_id = json["booking_id"],
    service_due = json["service_due"],
    service_types = json["service_types"],
    service_price = json["service_price"],
    urls = (json["data"] as Iterable).map((e) => Vehicle_URL.fromJson(e)).toList();

}