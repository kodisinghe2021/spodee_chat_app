import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:spordee_chat_v1_app/bloc/chat_invitation_bloc/chat_invitation_bloc.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/dotenv.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

//==================================== init stomp client and activate
Future<bool> activateInvitation() async {
   Logger().v("activateInvitation() >>>>>");
  scSendInvitation.activate();
  if (scSendInvitation.connected) {
    Logger().i("Connected.........");
  }
  await Future.delayed(const Duration(milliseconds: 1000));
  return true;
}

//==================================== Make stomp client object
final scSendInvitation = StompClient(
  config: StompConfig(
    url: WS_URL,
    onConnect: subscribeToInvitation,
    onWebSocketDone: () async {
      Logger().i('Connection Done !');
    },
    onDisconnect: (StompFrame frame) async {
      Logger().d('Disconnected ... ${frame.body}');
    },
    beforeConnect: () async {
      Logger().i('waiting to connect...');
    },
    onWebSocketError: (dynamic error) =>
        Logger().e("Connection ERRPR:: ${error.toString()}"),
    // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);

//====================================== Subscribe stomp client
void subscribeToInvitation(StompFrame frame) async {
  Logger().i("ON CONNECT ++++==>> Triggered");
  String? userId = await LocalStore().getData(Keys.userId.name);

  if (userId == null) {
    Logger().d("Chat Room ID IS EMPTY");
    return;
  }
  // Logger().d("Chat Room ID:: $chatRoomId");
  Logger().w("Waiting for subscribe");
  await Future.delayed(const Duration(milliseconds: 1000));
  scSendInvitation.subscribe(
    destination: "/topic/"+userId+".public.invitation",
    callback: (frame) {
      Logger().i("On Subscribe :: Callback :: ==>> ${frame.body.toString()}");
      if (frame.body != null) {
        Logger().d("Received ::: ${frame.body}");
        Map<String, dynamic> res =
            jsonDecode(frame.body.toString()) as Map<String, dynamic>;

            // InvitationBloc().add(InvitationReceivedEvent(chatRoomId: res["roomId"]));
       Logger().d("response Received :: $res");

       ChatInvitationBloc().add(ChatInvitationReceivedEvent(roomId: res["roomId"]));
      } else {
        Logger().i("body is null");
      }
    },
  );
}


//=================================== send invitation
