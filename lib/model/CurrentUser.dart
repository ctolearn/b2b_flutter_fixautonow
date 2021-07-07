class CurrentUser {
  String current_role;
  String current_company;
  String current_email;
  String current_id;
  String current_status;

  CurrentUser(
      {this.current_role,
      this.current_company,
      this.current_email,
      this.current_id,
      this.current_status});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    current_role = json['current_role'];
    current_company = json['current_company'];
    current_email = json['current_email'];
    current_id = json['current_id'];
    current_status = json['current_status'];
  }
}
