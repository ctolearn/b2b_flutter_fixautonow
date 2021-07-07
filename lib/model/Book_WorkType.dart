
class Book_WorkType{
  String id;
  String name;
  String description;
  String price;
  Book_WorkType({
    this.id,
    this.name,
    this.description,
    this.price
});
  Book_WorkType.fromJson(Map<String,dynamic> json):
     id = json["id"],
     name = json["name"],
     description = json["description"],
     price = json["price"];

}