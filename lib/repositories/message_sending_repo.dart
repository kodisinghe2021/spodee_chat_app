import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:spordee_chat_v1_app/repositories/dio_initilizer.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

class MessageSendingRepo {
  final DioInit _dioInit = DioInit();
  final _localStore = LocalStore();

  Future<bool> sendMessage({
    required String fromUser,
    required String text,
  }) async {
    Logger().v("sendMessage()");
    String? roomId = await _localStore.getData(Keys.charoomId.name);
    if (roomId == null) {
      Logger().e("Room ID NULL");
      return false;
    }
    try {
      Response response = await _dioInit.dioInit.post(
        "/api/messages/" + roomId,
        data: {
          "fromUser": fromUser,
          "text": text,
        },
        // queryParameters: {"forUser": null},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Logger().e("Dio ERROR : ${e.error}");
      return false;
    } catch (e) {
      Logger().e("ERROR : $e");
      return false;
    }
  }
}
