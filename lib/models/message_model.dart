import 'dart:convert';

class MessageModel {
  String message;
  String time;
  String fromUser;
  MessageModel({
    required this.message,
    required this.time,
    required this.fromUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'time': time,
      'fromUser': fromUser,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      time: map['time'] as String,
      fromUser: map['fromUser'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
