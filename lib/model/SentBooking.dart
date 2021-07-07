class SentBooking{
  String company_buyer_id;
  String company_seller_id;
  String booking_id;
  String timestamp;
  String vehicle_type;
  String vehicle_make;
  String vehicle_model;
  String vehicle_year;
  String plate_number;
  String no_range;
  String max_price;
  String min_price;
  String date;
  String time;
  String ref;
  String path;
  String status;
  SentBooking.fromJson(Map<String,dynamic> json):
        company_buyer_id  = json["company_buyer_id "],
        company_seller_id  = json["company_seller_id"],

        booking_id  = json["booking_id"],
        timestamp  = json["timestamp"],
        vehicle_type  = json["vehicle_type"],
        vehicle_make  = json["vehicle_make"],
        vehicle_model  = json["vehicle_model"],
        vehicle_year  = json["vehicle_year"],

        plate_number  = json["plate_number"],
        no_range  = json["no_range"],
        max_price  = json["max_price"],
        min_price  = json["min_price"],
        date  = json["date"],
        time  = json["time"],
        ref  = json["ref"],
        status = json["status"],
        path  = json["path"];
}
