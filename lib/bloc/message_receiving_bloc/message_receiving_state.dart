part of 'message_receiving_bloc.dart';

class MessageReceivingState {}

class MessageReceivingInitial extends MessageReceivingState {}

class MessageReceivedState extends MessageReceivingState {
  List<MessageModel> models;
  MessageReceivedState({required this.models});
}
