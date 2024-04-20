import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/listners/creat_room_listner.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  static final ChatRoomBloc _instance = ChatRoomBloc._internal();
  factory ChatRoomBloc() => _instance;
  final LocalStore _localStore = LocalStore();
  ChatRoomBloc._internal() : super(ChatRoomInitial()) {
    on<ChatRoomEvent>((event, emit) async {

      if (event is ChatRoomCreateFromInvitationEvent) {
        String? roomId = await _localStore.getData(Keys.charoomId.name);
        if (roomId == null) {
          return emit(ChatRoomInitFailedState());
        }
        await activeChatRoom();
        await Future.delayed(const Duration(milliseconds: 1000));
        emit(ChatRoomInitSuccessState());
      }
    });
  }
}
