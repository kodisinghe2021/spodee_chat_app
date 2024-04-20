import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/models/message_model.dart';

part 'message_receiving_event.dart';
part 'message_receiving_state.dart';

class MessageReceivingBloc
    extends Bloc<MessageReceivingEvent, MessageReceivingState> {
  static final MessageReceivingBloc _instance =
      MessageReceivingBloc._internal();
  factory MessageReceivingBloc() => _instance;
  List<MessageModel> _messageModels = [];
  MessageReceivingBloc._internal() : super(MessageReceivingInitial()) {
    on<MessageReceivingEvent>((event, emit) {
      if (event is MessageReceivedEvent) {
        _messageModels.add(event.model);
        emit(MessageReceivedState(models: [..._messageModels]));
      }
    });
  }
}
