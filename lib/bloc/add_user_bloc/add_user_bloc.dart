import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:spordee_chat_v1_app/models/user_model.dart';
import 'package:spordee_chat_v1_app/repositories/add_user_repo.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  static final AddUserBloc _instance = AddUserBloc._internal();
  factory AddUserBloc() => _instance;
  final AddUserRepository _addUserRepository = AddUserRepository();

  AddUserBloc._internal() : super(AddUserInitial()) {
    on<AddUserEvent>((event, emit) async {
      if (event is AddUserStartSearchingEvent) {
        emit(AddUserSearchingState());
        UserModel? model = await _addUserRepository.findUser(event.mobile);
        if (model != null) {
          emit(AddUserFoundState(userModel: model));
        }
      }

      if (event is AddUserSendInvitationEvent) {
        Logger().v("AddUserSendInvitationEvent");

        String? id = await _addUserRepository.addMemberToChat(event.userName);
        if (id != null) {
          Logger().i("ID IS :: $id");
          bool isSent =
              await _addUserRepository.sendInvitation(event.receiverId);
          if (isSent) {
            emit(AddUserSuccessState());
          }
        }
      }
    });
  }
}
