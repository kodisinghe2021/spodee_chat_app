import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:spordee_chat_v1_app/models/user_model.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/repositories/registration_repo.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  static final RegistrationBloc _instance = RegistrationBloc._internal();
  factory RegistrationBloc() => _instance;
  final RegistrationRepo _repo = RegistrationRepo();
  final LocalStore _localStore = LocalStore();
  RegistrationBloc._internal() : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) async {
      if (event is RegistrationEventStart) {
        Logger().v("RegistrationEvent");
        UserModel? model = await _repo.registerUser(
          userId: event.userId,
          mobileNumber: event.mobileNumber,
          firstName: event.firstName,
          lastName: event.lastName,
          active: event.active,
          password: event.password,
        );
        if (model != null) {
          await _localStore.insertData(Keys.userId.name, model.userId);
          emit(RegistrationSuccessState());
          await Future.delayed(const Duration(milliseconds: 500));
          AuthenticationBloc().add(AuthenticationEventStart());
        } else {
          emit(RegistrationFailedState());
        }
      }
    });
  }
}
