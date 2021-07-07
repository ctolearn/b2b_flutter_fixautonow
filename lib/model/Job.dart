class Job{
  //for pending job
  String date;
  String time;
  String address;
  String id;
  String ref;
  String status;
  String parent_name;
  String company_name;
  //
  Job.fromJson(Map<String,dynamic> json):
        date = json["date"],
        time = json["time"],
        address = json["address"],
        id = json["id"],
        ref = json["ref"],
        status = json["status"],
        parent_name = json["parent_name"],
        company_name = json["company_name"];


}