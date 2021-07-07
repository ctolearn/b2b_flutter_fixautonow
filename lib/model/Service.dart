
import 'Company_WorkType.dart';

class Service{
  String service_id;
  String service_category_id;
  String service_category_name;
  String service_name;
  String service_start;
  String service_end;
  String service_approximate;
  String service_description;
  String service_status;
  String service_photo;
  String vehicle_type;

  /** for booking  **/
  String parent;
  String company_name;
  String company_id;
  String company_address;
  String company_state;
  String company_city;
  String company_country;
  String parent_company_name;
  String parent_company_address;
  String parent_company_state;
  String parent_company_city;
  String parent_company_country;
  List<Company_WorkType> companyWorkTypeList;
  Service();
  Service.fromJson(Map<String,dynamic> json):
        service_id =  json["service_id"],
        service_category_id =  json["service_category_id"],
        service_category_name = json["service_category_name"],
        service_name = json["service_name"],
        service_start = json["service_start"],
        service_end = json["service_end"],
        service_approximate = json["service_approximate"],
        service_description = json["service_description"],
        service_status = json["service_status"],
        service_photo = json["service_photo"],
        vehicle_type = json["service_vehicle_type"],

        companyWorkTypeList =  (json["data"] as Iterable)==null ? List<Company_WorkType>.empty() :(json["data"] as Iterable).map((e) => Company_WorkType.fromJson(e)).toList(),

        parent = json["parent"],
        company_name = json["company_name"],
        company_id = json["company_id"],
        company_address = json["company_address"],
        company_state = json["company_state"],
        company_city = json["company_city"],
        company_country = json["company_country"],
        parent_company_name = json["parent_company_name"],
        parent_company_address = json["parent_company_address"],
        parent_company_state = json["parent_company_state"],
        parent_company_city = json["parent_company_city"],
        parent_company_country = json["parent_company_country"]

  ;
}