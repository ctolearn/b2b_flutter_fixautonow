class DashBoardBook{
  String id;
  String timestamp;
  String date;
  String time;
  String service_id;
  String vehicle_type;
  String vehicle_model;
  String vehicle_make;
  String book_id;
  String price;
  String status;
  String is_you;
  int distance;
  String not_ban_id;
  String company_name;
  String company_country;
  String company_address;
  String category_name;
 // DashBoardBook({this.id});
  //simplest way
  DashBoardBook.fromJson(Map<String,dynamic> json):
    id = json["id"],
    timestamp =	json["timestamp"],
    date =	json["date"],
    time =	json["time"],
    service_id = json["service_id"],
    vehicle_type = json["vehicle_type"],
    vehicle_model = json["vehicle_model"],
        vehicle_make = json["vehicle_make"],
    book_id = json["book_id"],
    price = json["price"],
    status =	json["status"],
    is_you =	json["is_you"],
    distance =	json["distance"],
    not_ban_id =	json["not_ban_id"],
    company_name =	json["company_name"],
    company_country =	json["company_country"],
    company_address =	json["company_address"],
    category_name =	json["category_name"];

/*
//other way
  factory DashBoardBook.fromJsonModel(Map<String,dynamic> json){
    return DashBoardBook(id: json[""]);
  }*/

}