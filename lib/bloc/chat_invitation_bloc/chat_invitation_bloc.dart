import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/bloc/chat_room_bloc/chat_room_bloc.dart';
import 'package:spordee_chat_v1_app/listners/creat_room_listner.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

part 'chat_invitation_event.dart';
part 'chat_invitation_state.dart';

class ChatInvitationBloc
    extends Bloc<ChatInvitationEvent, ChatInvitationState> {
  static final ChatInvitationBloc _instance = ChatInvitationBloc._internal();
  factory ChatInvitationBloc() => _instance;
  final LocalStore _localStore = LocalStore();
  ChatInvitationBloc._internal() : super(ChatInvitationInitial()) {
    on<ChatInvitationEvent>((event, emit) async {
      if (event is ChatInvitationReceivedEvent) {
        Logger().v("ChatInvitationReceivedEvent");
        await _localStore.insertData(Keys.charoomId.name, event.roomId);
        String? invitationKey =
            await _localStore.getData(Keys.charoomId.name);
        if (invitationKey != null) {
          Logger().i("Invitation Room id added to the local:::");
          // await _localStore.insertData(Keys.charoomId.name, event.roomId);
          bool isActive = await activeChatRoom();
          if (isActive) {
            ChatRoomBloc().add(
              ChatRoomCreateFromInvitationEvent(
                roomId: event.roomId,
                isAdmin: false,
              ),
            );

            emit(ChatInvitationReceivedState());
          }
        }
      }
    });
  }
}
