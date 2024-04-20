import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spordee_chat_v1_app/bloc/login_bloc/login_bloc.dart';
import 'package:spordee_chat_v1_app/screen/registration_screen.dart';
import 'package:spordee_chat_v1_app/utils/constant.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SizedBox(
        width: w(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _username,
                decoration: dec("username"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _password,
                decoration: dec("password"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  BlocProvider.of<LoginBloc>(context).add(
                    LoginStartEvent(
                      username: _username.text,
                      password: _password.text,
                    ),
                  );
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegistrationScreen(),
                    ),
                  );
                },
                child: const Text("Signin here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
