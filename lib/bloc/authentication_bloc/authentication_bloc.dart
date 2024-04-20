import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/listners/invitation_listner.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static final AuthenticationBloc _instance = AuthenticationBloc._internal();
  factory AuthenticationBloc() => _instance;

  AuthenticationBloc._internal() : super(AuthenticationInitial()) {
    LocalStore _localStore = LocalStore();
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationEventStart) {
        Logger().v("AuthenticationEventStart");
        emit(AuthenticationLoadingState());
        String? userId = await _localStore.getData(Keys.userId.name);
        if (userId != null) {
//============== When auth success listen to the invitation uri's
            await activateInvitation();
        Logger().v("AuthenticationSuccessState");
          emit(AuthenticationSuccessState());
        }else{
        Logger().v("AuthenticationFailedState");
          emit(AuthenticationFailedState());
        }
      }
    });
  }
}
