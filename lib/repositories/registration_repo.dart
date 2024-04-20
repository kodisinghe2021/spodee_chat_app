import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:spordee_chat_v1_app/models/user_model.dart';
import 'package:spordee_chat_v1_app/repositories/dio_initilizer.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/dotenv.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

class RegistrationRepo {
  final DioInit _dioInit = DioInit();
  Future<UserModel?> registerUser(
    {
    required String userId,
    required String mobileNumber,
    required String firstName,
    required String lastName,
    required bool active,
    required String password,
    }
  ) async {
    Logger().v("registerUser() >>>>>");

    // make model
    UserModel model = UserModel(userId: userId, mobileNumber: mobileNumber, firstName: firstName, lastName: lastName, active: active, password: password,);

    try {
      Response response = await _dioInit.dioInit.post(
        REGISTER_USER,
        data: model.toMap(),
      );
      Logger().d("Response status code: ${response.statusCode}");
      Logger().d("Response body: ${response.data}");
      // converted to map
      UserModel newModel = UserModel.fromMap(response.data);
      LocalStore().insertData(Keys.userId.name, newModel.userId);
      return newModel;
    } on DioException catch (e) {
      Logger().e("Dio error: ${e.error}");
      return null;
    } catch (e) {
      Logger().e("error: $e");
      return null;
    }
  }
}
