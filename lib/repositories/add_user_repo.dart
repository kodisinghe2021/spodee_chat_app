import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:spordee_chat_v1_app/models/user_model.dart';
import 'package:spordee_chat_v1_app/repositories/dio_initilizer.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/dotenv.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

class AddUserRepository {
  final LocalStore _localStore = LocalStore();
  Future<String?> addMemberToChat(String username) async {
    Logger().i("Waiting......");
    String? id = await _localStore.getData(Keys.charoomId.name);
    if (id == null) {
      Logger().e("CHAT ROOM ID IS EMPTY");
      return null;
    }
    try {
      Response response = await DioInit().dioInit.put(
        "$ADD_MEMBER_TO_CHAT/$id",
        data: {
          "username": username,
          "joinedAt": "2024-01-30T08:05:55.554Z",
        },
      );

      Logger().w("SUCCESS::${response.data}");
      return response.data["id"].toString();
    } catch (e) {
      Logger().e("ERROR!");
      return null;
    }
  }

  Future<UserModel?> findUser(String mobile) async {
    Logger().i("Mobile Number");

    try {
      Response response =
          await DioInit().dioInit.get("/api/user/by-mobile/$mobile");
      if (response.data != null) {
        Logger().i(response.data);
        return UserModel.fromMap(response.data);
      } else {
        Logger().w("Response null");
        return null;
      }
    } catch (e) {
      Logger().e("ERROR:: $e");
      return null;
    }
  }

  Future<bool> sendInvitation(String receiverId) async {
    Logger().v("sendInvitation :: $receiverId");
    String? roomId = await _localStore.getData(Keys.charoomId.name);
    if (roomId == null) {
      Logger().i("Room ID NUll");
      return false;
    }

    try {
      Response response = await DioInit().dioInit.post("/api/user/invite",
          data: {
            "receiverId": receiverId,
            "roomId": roomId,
          });
      if (response.statusCode == 200) {
        Logger().i(response.statusCode);
        return true;
      } else {
        Logger().w("Response null");
        return false;
      }
    } catch (e) {
      Logger().e("ERROR:: $e");
      return false;
    }
  }
}
