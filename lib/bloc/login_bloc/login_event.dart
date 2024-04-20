// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginEvent {}

class LoginOutEvent extends LoginEvent{}
class LoginStartEvent extends LoginEvent{
  String username;
  String password;
  LoginStartEvent({
    required this.username,
    required this.password,
  });
}
