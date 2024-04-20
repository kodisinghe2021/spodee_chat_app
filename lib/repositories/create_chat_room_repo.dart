import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:spordee_chat_v1_app/repositories/dio_initilizer.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/dotenv.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

class CreateChatRoomRepo {
  final LocalStore _localStore = LocalStore();

  Future<void> createChatRoom({
    required String username,
    required String roomName,
  }) async {
    Logger().i("Waiting......");
    try {
      Response response = await DioInit().dioInit.post(
        CREATE_CHAT_ROOM,
        data: {
          "name": roomName,
          "description": "ILABS Platform",
          "updatedAt": "2024-01-30T08:09:01.897Z",
          "connectedUsers": [
            {"username": username, "joinedAt": "2024-01-30T08:09:01.897Z"}
          ]
        },
      );
      Logger().w("SUCCESS::${response.data["id"]}");
      await _localStore.insertData(
          Keys.charoomId.name, response.data["id"].toString());

    } catch (e) {
      Logger().e("ERROR!");
    }
    Logger().i("Done!");
  }
}
