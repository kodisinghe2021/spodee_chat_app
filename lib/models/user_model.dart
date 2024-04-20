import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String userId;
  String mobileNumber;
  String firstName;
  String lastName;
  bool active;
  String password;
  UserModel({
    required this.userId,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.active,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'mobileNumber': mobileNumber,
      'firstName': firstName,
      'lastName': lastName,
      'active': active,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      mobileNumber: map['mobileNumber'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      active: map['active'] as bool,
      password: map['password'] == null ? "" : map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
