import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:spordee_chat_v1_app/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/bloc_routes_bloc/bloc_routes_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/chat_invitation_bloc/chat_invitation_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/chat_room_bloc/chat_room_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/create_chat_room_bloc/create_chat_room_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/login_bloc/login_bloc.dart';
import 'package:spordee_chat_v1_app/repositories/local_store.dart';
import 'package:spordee_chat_v1_app/repositories/registration_repo.dart';
import 'package:spordee_chat_v1_app/screen/chat_room_screen.dart';
import 'package:spordee_chat_v1_app/utils/constant.dart';
import 'package:spordee_chat_v1_app/utils/keys.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _chatRoomName = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _adminName = TextEditingController();

  Future<String?> getRoomId() async {
    String? roomId = await LocalStore().getData(Keys.charoomId.name);
    if (roomId != null) {
      return roomId;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocRoutesBloc, BlocRoutesState>(
      builder: (context, blocRoutes) {
        if (blocRoutes is BlocRoutesToChatRoomState) {
          return ChatRoomScreen();
        }
        return BlocBuilder<CreateChatRoomBloc, CreateChatRoomState>(
          builder: (context, createChatRoomState) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(LoginOutEvent());
                    },
                    icon: const Icon(Icons.logout),
                  ),
                  actions: [
                    BlocBuilder<ChatInvitationBloc, ChatInvitationState>(
                      builder: (context, chatroomInvitationState) {
                        if (chatroomInvitationState
                            is ChatInvitationReceivedState) {
                          return GestureDetector(
                            onTap: () {
                              Logger().i("Tapped");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ChatRoomScreen(),
                              //   ),
                              // );
                              BlocProvider.of<BlocRoutesBloc>(context)
                                  .add(BlocRoutesToChatRoomEvent());
                            },
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Stack(
                                children: [
                                  const Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Icon(
                                      Icons.notifications_active,
                                      size: 30,
                                    ),
                                  ),
                                  Positioned(
                                    top: 9,
                                    left: 9,
                                    child: Container(
                                      width: 14,
                                      height: 14,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.notifications_active,
                            size: 30,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                body: Container(
                  width: w(context),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (createChatRoomState
                          is CreateChatRoomCreatedSuccess) ...{
                        TextFormField(
                          controller: _mobile,
                          decoration: searchBarDec(
                            "mobile number",
                            () async {
                              BlocProvider.of<AddUserBloc>(context).add(
                                AddUserStartSearchingEvent(
                                  mobile: _mobile.text,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<AddUserBloc, AddUserState>(
                          builder: (context, addUserState) {
                            if (addUserState is AddUserFoundState) {
                              return ListTile(
                                title: Text(
                                    "${addUserState.userModel.firstName} ${addUserState.userModel.lastName}"),
                                trailing: TextButton(
                                  onPressed: () {
                                    BlocProvider.of<AddUserBloc>(context).add(
                                      AddUserSendInvitationEvent(
                                        receiverId:
                                            addUserState.userModel.userId,
                                        userName:
                                            addUserState.userModel.firstName,
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Send Invitation",
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ChatRoomScreen(),
                            //   ),
                            // );
                            Logger().d("Tapped");
                            BlocProvider.of<BlocRoutesBloc>(context)
                                .add(BlocRoutesToChatRoomEvent());
                          },
                          child: const Text("Go to chat room"),
                        ),
                      } else ...{
                        TextFormField(
                          controller: _chatRoomName,
                          decoration: dec("Room name here"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _adminName,
                          decoration: dec("Your name here"),
                        ),
                        const SizedBox(height: 20),
                        BlocConsumer<CreateChatRoomBloc, CreateChatRoomState>(
                          listener: (context, state) {
                            if (state is CreateChatRoomCreatedSuccess) {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ChatRoomScreen(),
                              //   ),
                              // );
                              BlocProvider.of<BlocRoutesBloc>(context)
                                  .add(BlocRoutesToChatRoomEvent());
                            }
                          },
                          builder: (context, state) {
                            if (state is CreateChatRoomCreatedLoading) {
                              return const CupertinoActivityIndicator();
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                CreateChatRoomBloc().add(
                                  CreateNewChatRoomStartEvent(
                                    chatRoomName: _chatRoomName.text,
                                    userName: _adminName.text,
                                  ),
                                );
                              },
                              child: const Text("Creat Chat Room"),
                            );
                          },
                        ),
                      },
                      const SizedBox(height: 20),
                      FutureBuilder<String?>(
                        future: getRoomId(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ChatRoomScreen(),
                                //   ),
                                // );
                                BlocProvider.of<BlocRoutesBloc>(context)
                                    .add(BlocRoutesToChatRoomEvent());
                              },
                              child: Text(
                                snapshot.data.toString(),
                              ),
                            );
                          }

                          return const Text("No Chat Rooms");
                        },
                      ),
                      // if (roomId != null) ...{
                      //   Text("Room id; $roomId"),
                      // },
                      // if (roomId != null) ...{

                      // },
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
