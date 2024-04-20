// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_room_bloc.dart';

class ChatRoomEvent {}

class ChatRoomCreateFromInvitationEvent extends ChatRoomEvent {
  String roomId;
  bool isAdmin;
  ChatRoomCreateFromInvitationEvent({
    required this.roomId,
    required this.isAdmin,
  });
}

class ChatRoomCreateEvent extends ChatRoomEvent {}
