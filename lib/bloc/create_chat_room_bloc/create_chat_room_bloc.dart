import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/bloc/chat_room_bloc/chat_room_bloc.dart';
import 'package:spordee_chat_v1_app/listners/creat_room_listner.dart';
import 'package:spordee_chat_v1_app/repositories/create_chat_room_repo.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

part 'create_chat_room_event.dart';
part 'create_chat_room_state.dart';

class CreateChatRoomBloc
    extends Bloc<CreateChatRoomEvent, CreateChatRoomState> {
  static final CreateChatRoomBloc _instance = CreateChatRoomBloc._internal();
  factory CreateChatRoomBloc() => _instance;
  final LocalStore _localStore = LocalStore();
  final CreateChatRoomRepo _createChatRoomRepo = CreateChatRoomRepo();

  CreateChatRoomBloc._internal() : super(CreateChatRoomInitial()) {
    on<CreateChatRoomEvent>((event, emit) async {
      if (event is LoadChatRoomByInvitation) {
        emit(CreateChatRoomCreatedLoading());
        Logger().v("CreateChatRoomStartEvent");
        String? chatRoomId = await _localStore.getData(Keys.charoomId.name);
        if (chatRoomId != null) {
          Logger().i("Chat Room Id :: $chatRoomId");
          await activeChatRoom();
          await Future.delayed(const Duration(milliseconds: 1000));
          emit(CreateChatRoomCreatedSuccess());
        } else {
          Logger().e("Chat Room ID NULL");
          emit(CreateChatRoomCreatedFailed());
        }
      }

      if (event is CreateNewChatRoomStartEvent) {
        emit(CreateChatRoomCreatedLoading());
        await _createChatRoomRepo.createChatRoom(
          username: event.userName,
          roomName: event.chatRoomName,
        );
        String? chatRoomId = await _localStore.getData(Keys.charoomId.name);
        if (chatRoomId != null) {
          Logger().i("Chat Room Id :: $chatRoomId");
          await activeChatRoom();
          await Future.delayed(const Duration(milliseconds: 1000));
          ChatRoomBloc().add(
            ChatRoomCreateFromInvitationEvent(
              roomId: chatRoomId,
              isAdmin: true,
            ),
          );
          emit(CreateChatRoomCreatedSuccess());
        } else {
          emit(CreateChatRoomCreatedFailed());
        }
      }
    });
  }
}
