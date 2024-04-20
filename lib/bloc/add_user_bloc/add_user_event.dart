// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_user_bloc.dart';

class AddUserEvent {}

class AddUserStartSearchingEvent extends AddUserEvent {
  String mobile;
  AddUserStartSearchingEvent({
    required this.mobile,
  });
}

class AddUserSendInvitationEvent extends AddUserEvent{
  String receiverId;
  String userName;
  AddUserSendInvitationEvent({
    required this.receiverId,
    required this.userName,
  });

}
