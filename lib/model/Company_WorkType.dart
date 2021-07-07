class Company_WorkType {
  String work_id;
  String type_name;
  String type_description;
  String type_price;

  Company_WorkType(
      this.work_id, this.type_name, this.type_description, this.type_price);

  Company_WorkType.fromJson(Map<String, dynamic> json)
      : work_id = json["id"],
        type_name = json["type_name"],
        type_description = json["type_description"],
        type_price = json["type_price"];

  Map<String, dynamic> toJson() => {
        "work_id": work_id,
        "type_name": type_name,
        "type_description": type_description,
        "type_price": type_price
      };
}
