// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_sending_bloc.dart';

class MessageSendingEvent {}

class MessageSendEvent extends MessageSendingEvent{
  String fromUser;
  String text;
  MessageSendEvent({
    required this.fromUser,
    required this.text,
  });
}
