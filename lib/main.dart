import 'package:flutter/material.dart';
import 'package:spordee_chat_v1_app/root_home.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  runApp(const RootHome());
}
