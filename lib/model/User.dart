class User{
  String employee_id;
  String email;
  String firstname;
  String lastname;
  String mobile;
  String type;
  String c_code;
  String role_id;
  User();
  User.fromJson(Map<String,dynamic> json):
        employee_id = json["employee_id"],
        email = json["email"],
        firstname = json["firstname"],
        lastname = json["lastname"],
        mobile = json["mobile"],
        type = json["type"],
        role_id = json["role_id"],
        c_code = json["c_code"]
      ;
}