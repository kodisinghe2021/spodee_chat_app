import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spordee_chat_v1_app/bloc/bloc_routes_bloc/bloc_routes_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/chat_room_bloc/chat_room_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/message_receiving_bloc/message_receiving_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/message_sending_bloc/message_sending_bloc.dart';
import 'package:spordee_chat_v1_app/utils/constant.dart';

class ChatRoomScreen extends StatefulWidget {
  ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  void dispose() {
    BlocRoutesBloc().add(BlocRoutesPopEvent());
    super.dispose();
  }

  final TextEditingController _message = TextEditingController();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  Future<bool> back() async {
    BlocProvider.of<BlocRoutesBloc>(context).add(BlocRoutesPopEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: back,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
                  BlocProvider.of<BlocRoutesBloc>(context).add(BlocRoutesPopEvent());
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ),
        body: BlocProvider<ChatRoomBloc>(
          create: (context) => ChatRoomBloc(),
          child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
            builder: (context, state) {
              if (state is ChatRoomInitSuccessState) {
                return BlocProvider<MessageSendingBloc>(
                  create: (context) => MessageSendingBloc(),
                  child: BlocBuilder<MessageSendingBloc, MessageSendingState>(
                    builder: (context, messageSendingState) {
                      return SizedBox(
                        width: w(context),
                        height: h(context),
                        child: Column(
                          children: [
                     
                            BlocBuilder<MessageReceivingBloc,
                                  MessageReceivingState>(
                                builder: (context, messageReceivingState) {
                                  if (messageReceivingState
                                      is MessageReceivedState) {
                                    return Expanded(
                                        child: ListView.builder(
                                      itemCount:
                                          messageReceivingState.models.length,
                                      itemBuilder: (context, index) => ListTile(
                                        title: Text(
                                          messageReceivingState
                                              .models[index].message,
                                        ),
                                        subtitle: Text(
                                          "From: ${messageReceivingState.models[index].fromUser}   ${messageReceivingState.models[index].time}",
                                        ),
                                      ),
                                    ));
                                  }
                                  return const Expanded(
                                    flex: 9,
                                    child: Text("No messages"),
                                  );
                                },
                              ),
                           
                           
                          
                            SizedBox(
                              width: w(context),
                              height: h(context) * .1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _message,
                                      decoration: dec("Type you message.."),
                                    ),
                                  ),
                                  if (state is MessageSendingLoading) ...{
                                    LoadingAnimationWidget
                                        .horizontalRotatingDots(
                                      color: Colors.blueAccent,
                                      size: 20,
                                    ),
                                  },
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      top: 10,
                                    ),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () async {
                                        // await AllRepos().sendMessage(
                                        //   message: _message.text,
                                        // );
                                        MessageSendingBloc().add(
                                          MessageSendEvent(
                                            fromUser: "fromUser",
                                            text: _message.text,
                                          ),
                                        );
                                        _message.clear();
                                      },
                                      icon: Transform(
                                        transform: Matrix4.rotationZ(-.7),
                                        child: const Icon(
                                          Icons.send,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: Text("Initilizing room...."),
              );
            },
          ),
        ),
      ),
    );
  }
}
