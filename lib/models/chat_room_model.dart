import 'dart:convert';

import 'package:spordee_chat_v1_app/models/connected_users.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatRoomModel {
  String name;
  String description;
  String updatedAt;
  List<ConnectedUsers> connectedUsers;
  ChatRoomModel({
    required this.name,
    required this.description,
    required this.updatedAt,
    required this.connectedUsers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'updatedAt': updatedAt,
      'connectedUsers': connectedUsers.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      name: map['name'] as String,
      description: map['description'] as String,
      updatedAt: map['updatedAt'] as String,
      connectedUsers: [],
      
      // List<ConnectedUsers>.from(
      //   (map['connectedUsers'] as List<dynamic>).map<ConnectedUsers>(
      //     (x) => ConnectedUsers.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
