class Vehicle_URL{
  String url;
  Vehicle_URL.fromJson(Map<String,dynamic> json):
      url = json["url"];
}