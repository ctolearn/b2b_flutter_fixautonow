class Chat{
  String to_user;
  String company;
  String active;
  String timestamp;
  String ref;
  String chat_message;
  String booking_id;
  String is_read;
  bool is_bold;
  Chat.fromJson(Map<String,dynamic> json):
         to_user = json["to_user"],
         company= json["company"],
         active= json["active"],
         timestamp= json["timestamp"],
         ref= json["ref"],
         chat_message= json["chat_message"],
         booking_id= json["booking_id"],
        is_bold= json["is_bold"],
      is_read= json["is_read"];

}