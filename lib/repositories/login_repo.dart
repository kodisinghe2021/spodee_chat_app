import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:spordee_chat_v1_app/models/user_model.dart';
import 'package:spordee_chat_v1_app/repositories/dio_initilizer.dart';

class LoginRepository {
  final DioInit _dioInit = DioInit();

  Future<UserModel?> login(String username, String password) async {
    Logger().v("login");
    try {
      Response response = await _dioInit.dioInit
          .post("/api/user/login/" + username + "/" + password);
      if (response.data != null) {
        Logger().i("Response :: ${response.data}");
        UserModel model = UserModel.fromMap(response.data);
        Logger().i("Response Model:: ${model.firstName}");
        return model;
      } else {
        Logger().e("Response NULL");
        return null;
      }
    } on DioException catch (e) {
      Logger().e("Dio Error :: ${e.error}");
      return null;
    } catch (e) {
      Logger().e("Dio Error :: $e");
      return null;
    }
  }
}
