import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:spordee_chat_v1_app/models/user_model.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/repositories/login_repo.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static final LoginBloc _instance = LoginBloc._internal();
  factory LoginBloc() => _instance;
  final LocalStore _localStore = LocalStore();
  final LoginRepository _loginRepo = LoginRepository();
  LoginBloc._internal() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginOutEvent) {
        await _localStore.clearAll();
        AuthenticationBloc().add(AuthenticationEventStart());
      }

      if (event is LoginStartEvent) {
        UserModel? model = await _loginRepo.login(
          event.username,
          event.password,
        );
        if (model != null) {
          await _localStore.insertData(Keys.userId.name, model.userId);
          emit(LoginSuccessState());
          AuthenticationBloc().add(AuthenticationEventStart());
        }
      }
    });
  }
}
