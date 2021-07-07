class WorkType_Selection{
  String name;
  String id;
  String description;
  WorkType_Selection(this.name,this.id,this.description);
  WorkType_Selection.fromJson(Map<String,dynamic> json):
    name = json["name"],
    id = json["id"],
    description = json["description"];

  Map<String,dynamic> toJson()=>
      {
       'name':name,
        'id':id,
        'description':description
  };


}
