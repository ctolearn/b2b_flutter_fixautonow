


import 'Book_AddOn.dart';
import 'Book_WorkType.dart';
import 'Company_WorkType.dart';

class Invoice_Information {
  String service_price;
  String service_name;
  String invoice_id;
  String parent_name;
  String name;
  String state;
  String city;
  String country;
  String address;
  String order_by_email;
  String seller_parent_name;
  String seller_name;
  String seller_state;
  String seller_city;
  String seller_country;
  String seller_address;
  String seller_email;
  String seller_contact;
  String model;
  String plate;
  String plate_number;
  String email;
  String contact;
  String c_code;
  List<Book_AddOn> bookAddOns;
  List<Book_WorkType> bookWorkTypes;
  List<Company_WorkType> companyWorkTypes;
  Invoice_Information.fromJson(Map<String, dynamic> json)
      : service_price = json["service_price"],
        service_name = json["service_name"],
        invoice_id = json["invoice_id"],
        parent_name = json["parent_name"],
        name = json["name"],
        state = json["state"],
        city = json["city"],
        country = json["country"],
        address = json["address"],
        order_by_email = json["order_by_email"],
        seller_parent_name = json["seller_parent_name"],
        seller_name = json["seller_name"],
        seller_state = json["seller_state"],
        seller_city = json["seller_city"],
        seller_country = json["seller_country"],
        seller_address = json["seller_address"],
        seller_email = json["seller_email"],
        seller_contact = json["seller_contact"],
        model = json["model"],
        plate = json["plate"],
        plate_number = json["plate_number"],
        email = json["email"],
        contact = json["contact"],
        c_code = json["c_code"],
        bookAddOns = (json["data"] as Iterable).map((e) => Book_AddOn.fromJson(e)).toList(),
        bookWorkTypes = (json["services"] as Iterable).map((e) => Book_WorkType.fromJson(e)).toList(),
        companyWorkTypes = (json["types"] as Iterable).map((e) => Company_WorkType.fromJson(e)).toList();



}
