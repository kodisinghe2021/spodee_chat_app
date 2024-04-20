import 'dart:convert';

class ConnectedUsers {
  String username;
  String joinedAt;
  ConnectedUsers({
    required this.username,
    required this.joinedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'joinedAt': joinedAt,
    };
  }

  factory ConnectedUsers.fromMap(Map<String, dynamic> map) {
    return ConnectedUsers(
      username: map['username'] as String,
      joinedAt: map['joinedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectedUsers.fromJson(String source) =>
      ConnectedUsers.fromMap(json.decode(source) as Map<String, dynamic>);
}
