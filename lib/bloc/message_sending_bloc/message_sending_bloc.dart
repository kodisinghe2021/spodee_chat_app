import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/repositories/message_sending_repo.dart';

part 'message_sending_event.dart';
part 'message_sending_state.dart';

class MessageSendingBloc
    extends Bloc<MessageSendingEvent, MessageSendingState> {
  MessageSendingBloc() : super(MessageSendingInitial()) {
    final MessageSendingRepo _repo = MessageSendingRepo();
    on<MessageSendingEvent>((event, emit) async {
      if (event is MessageSendEvent) {
        emit(MessageSendingLoading());
        bool isSuccess = await _repo.sendMessage(
          fromUser: "AA",
          text: event.text,
        );
        if (isSuccess) {
          emit(MessageSendingSuccess());
        } else {
          emit(MessageSendingFailed());
        }
      }
    });
  }
}
