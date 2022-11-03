class Message {
  final String message;
  final String socket_id;
  final String user_id;
  final String date;
  

  Message({
    required this.message,
    required this.socket_id,
    required this.user_id,
    required this.date,
  
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      message: message['message'].toString(),
      socket_id: message['socket_id'].toString(),
      user_id: message['user_id'].toString(),
      date: message['data'].toString(),
    );
  }

  toJson() {}
}
