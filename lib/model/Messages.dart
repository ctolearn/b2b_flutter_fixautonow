class Messages {
  String to_user;
  String company;
  String timestamp;
  String ref;
  String chat_message;
  String book_id;

  Messages.fromJson(Map<String, dynamic> json)
      : to_user = json["to_user"],
        company = json["company"],
        timestamp = json["timestamp"],
        ref = json["ref"],
        chat_message = json["chat_message"],
        book_id = json["booking_id"];
}
