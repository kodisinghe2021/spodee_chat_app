part of 'create_chat_room_bloc.dart';

class CreateChatRoomEvent {}

class CreateNewChatRoomStartEvent extends CreateChatRoomEvent {
  String chatRoomName;
  String userName;
  CreateNewChatRoomStartEvent({
    required this.chatRoomName,
    required this.userName,
  });
}

class LoadChatRoomByInvitation extends CreateChatRoomEvent {}
