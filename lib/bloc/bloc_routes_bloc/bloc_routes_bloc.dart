import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_routes_event.dart';
part 'bloc_routes_state.dart';

class BlocRoutesBloc extends Bloc<BlocRoutesEvent, BlocRoutesState> {
  static final BlocRoutesBloc _instance =BlocRoutesBloc._internal();
  factory BlocRoutesBloc() => _instance;
  BlocRoutesBloc._internal() : super(BlocRoutesInitial()) {
    on<BlocRoutesEvent>((event, emit) {
     if(event is BlocRoutesToChatRoomEvent){
      emit(BlocRoutesToChatRoomState());
     }
     if(event is BlocRoutesPopEvent){
      emit(BlocRoutesPopState());
     }
    });
  }
}
