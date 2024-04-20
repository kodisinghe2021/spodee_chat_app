import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/registration_bloc/registration_bloc.dart';
import 'package:spordee_chat_v1_app/utils/constant.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      create: (context) => RegistrationBloc(),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SizedBox(
              width: w(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _userId,
                      decoration: dec("username"),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _mobileNumber,
                      decoration: dec("mobile number"),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _firstName,
                      decoration: dec("first name"),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _lastName,
                      decoration: dec("last name"),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _password,
                      decoration: dec("password"),
                    ),
                    SizedBox(height: 20),
                    if (state is AuthenticationLoadingState) ...{
                      const CupertinoActivityIndicator(),
                    } else ...{
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<RegistrationBloc>(context).add(
                            RegistrationEventStart(
                              userId: _userId.text,
                              mobileNumber: _mobileNumber.text,
                              firstName: _firstName.text,
                              lastName: _lastName.text,
                              password: _password.text,
                              active: true,
                            ),
                          );
                          // RegistrationBloc().add(
                          //   RegistrationEventStart(
                          //     userId: _userId.text,
                          //     mobileNumber: _mobileNumber.text,
                          //     firstName: _firstName.text,
                          //     lastName: _lastName.text,
                          //     password: _password.text,
                          //     active: true,
                          //   ),
                          // );
                             Navigator.pop(context);
                        },
                        child: const Text("Register"),
                      ),
                    },
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text("Login here"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
