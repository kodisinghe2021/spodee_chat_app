import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/bloc_routes_bloc/bloc_routes_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/chat_invitation_bloc/chat_invitation_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/create_chat_room_bloc/create_chat_room_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/login_bloc/login_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/message_receiving_bloc/message_receiving_bloc.dart';
import 'package:spordee_chat_v1_app/screen/home_screen.dart';
import 'package:spordee_chat_v1_app/screen/login_screen.dart';
import 'package:spordee_chat_v1_app/screen/splash_screen.dart';

class RootHome extends StatelessWidget {
  const RootHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc()
              ..add(
                AuthenticationEventStart(),
              ),
          ),
          BlocProvider<ChatInvitationBloc>(
            create: (context) => ChatInvitationBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider<CreateChatRoomBloc>(
            create: (context) => CreateChatRoomBloc(),
          ),
          BlocProvider<AddUserBloc>(
            create: (context) => AddUserBloc(),
          ),
          BlocProvider<BlocRoutesBloc>(
            create: (context) => BlocRoutesBloc(),
          ),
          BlocProvider<MessageReceivingBloc>(
            create: (context) => MessageReceivingBloc(),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationFailedState) {
              return LoginPage();
            }
            if (state is AuthenticationSuccessState) {
              return HomePage();
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
