class AddOn{
  String addon_id;
  String addon_name;
  String addon_price;
  String addon_description;
  String addon_status;
  AddOn();
  AddOn.fromJson(Map<String,dynamic> json):
        addon_id =  json["addon_id"],
        addon_name = json["addon_name"],
        addon_price = json["addon_price"],
        addon_description = json["addon_description"],
        addon_status = json["addon_status"];
}