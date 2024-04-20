// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_receiving_bloc.dart';

class MessageReceivingEvent {}

class MessageReceivedEvent extends MessageReceivingEvent {
  MessageModel model;
  MessageReceivedEvent({
    required this.model,
  });
}
