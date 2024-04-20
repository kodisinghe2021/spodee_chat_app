part of 'add_user_bloc.dart';

class AddUserState {}

class AddUserInitial extends AddUserState {}

class AddUserSearchingState extends AddUserState {}

class AddUserFoundState extends AddUserState {
  AddUserFoundState({required this.userModel});
  UserModel userModel;
}

class AddUserNotFoundState extends AddUserState {}
class AddUserSuccessState extends AddUserState {}
