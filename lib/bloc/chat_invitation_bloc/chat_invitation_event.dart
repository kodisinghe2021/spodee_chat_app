// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_invitation_bloc.dart';

class ChatInvitationEvent {}

class ChatInvitationReceivedEvent extends ChatInvitationEvent {
  String roomId;
  ChatInvitationReceivedEvent({
    required this.roomId,
  });
}
