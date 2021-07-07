class Book_AddOn{
  String count;
  String total;
  String name;
  String description;
  String price;
  String addon_id;
  Book_AddOn({
    this.count,
    this.total,
    this.name,
    this.description,
    this.price,
    this.addon_id,
});
  Book_AddOn.fromJson(Map<String,dynamic> json):
     count = json["count"],
     total = json["total"],
     name = json["name"],
     description = json["description"],
     price = json["price"],
     addon_id = json["addon_id"];

}