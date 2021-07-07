import 'Book_AddOn.dart';
import 'Book_WorkType.dart';
import 'Company_WorkType.dart';

class Booking_Information {
  String parent_name;
  String name;
  String state;
  String city;
  String country;
  String address;
  String vehicle_type;
  String vehicle_model;
  String date;
  String time;
  String plate_number;
  String remarks;
  String service_id;
  String service_name;
  String service_price;
  String vehicle_make;
  String no_range;
  String min_price;
  String max_price;
  String id;
  String assigned_id;
  String firstname;
  String lastname;
  String job_id;
  String invoice_id;
  String email;
  String contact;
  String model;
  String plate;

  //data
  List<Book_WorkType> bookWorkTypes;

  //types company
  List<Company_WorkType> companyWorkTypes;

  //addons
  List<Book_AddOn> bookAddOns;

  Booking_Information.fromJson(Map<String, dynamic> json)
      : parent_name = json["parent_name"],
        name = json["name"],
        state = json["state"],
        city = json["city"],
        country = json["country"],
        address = json["address"],
        vehicle_type = json["vehicle_type"],
        vehicle_model = json["vehicle_model"],
        date = json["date"],
        time = json["time"],
        plate_number = json["plate_number"],
        remarks = json["remarks"],
        service_id = json["service_id"],
        service_name = json["service_name"],
        service_price = json["service_price"],
        vehicle_make = json["vehicle_make"],
        no_range = json["no_range"],
        min_price = json["min_price"],
        max_price = json["max_price"],
        id = json["id"],
        assigned_id = json["assigned_id"],
        firstname = json["firstname"],
        lastname = json["lastname"],
        job_id = json["job_id"],
        invoice_id = json["invoice_id"],
        email = json["email"],
        contact = json["contact"],
        model = json["model"],
        plate = json["plate"],
        bookAddOns = (json["data"] as Iterable)
            .map((e) => Book_AddOn.fromJson(e))
            .toList(),
        bookWorkTypes = (json["services"] as Iterable)
            .map((e) => Book_WorkType.fromJson(e))
            .toList(),
        companyWorkTypes = (json["types"] as Iterable)
            .map((e) => Company_WorkType.fromJson(e))
            .toList();
}
