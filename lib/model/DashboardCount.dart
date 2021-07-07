class DashboardCount{
  String services;
  String branches;
  String users;
  String sent_booking;
  String received_booking;
  String add_ons;
  DashboardCount.fromJson(Map<String,dynamic> json):
     services = json["services"],
     branches = json["branches"],
     users = json["users"],
     sent_booking = json["sent_booking"],
     add_ons = json["add_ons"],
     received_booking = json["received_booking"];
}