class ServiceItem{
  final String service_category;
  final String service_price;
  final String approx_work_time_to_finish;
  final String time_start;
  final String time_end;
  final String category_name;
  final String parent;
  final String company_name;
  final String company_id;
  final String company_address;
  final String company_state;
  final String company_city;
  final String company_country;
  final String parent_company_name;
  final String parent_company_address;
  final String parent_company_state;
  final String parent_company_city;
  final String parent_company_country;
  final String distance;
  final String name;
  final String description;
  final String vehicle_type;
  final String service_id;
  final String service_photo;
  final String rating;
  final String work_types;
  ServiceItem({
    this.distance,
    this.name,
    this.description,
    this.vehicle_type,
    this.service_id,
    this.service_photo,
    this.service_category,
    this.service_price,
    this.approx_work_time_to_finish,
    this.time_start,
    this.time_end,
    this.category_name,
    this.parent,
    this.company_name,
    this.company_id,
    this.company_address,
    this.company_state,
    this.company_city,
    this.company_country,
    this.parent_company_name,
    this.parent_company_address,
    this.parent_company_state,
    this.parent_company_city ,
    this.parent_company_country,
    this.rating,
    this.work_types
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
        distance : json["distance"],
        name : json["name"],
        description : json["description"],
        vehicle_type : json["vehicle_type"],
        service_id : json["service_id"],
        service_photo : json["service_photo"],
        service_category : json["service_category"],
        service_price : json["service_price"],
        approx_work_time_to_finish : json["approx_work_time_to_finish"],
        time_start : json["time_start"],
        time_end : json["time_end"],
        category_name : json["category_name"],
        parent : json["parent"],
        company_name : json["company_name"],
        company_id : json["company_id"],
        company_address : json["company_address"],
        company_state : json["company_state"],
        company_city : json["company_city"],
        company_country : json["company_country"],
        parent_company_name : json["parent_company_name"],
        parent_company_address : json["parent_company_address"],
        parent_company_state : json["parent_company_state"],
        parent_company_city : json["parent_company_city"],
        parent_company_country : json["parent_company_country"],
        rating: json["rating"],
        work_types: json["work_types"]
    );
  }
}