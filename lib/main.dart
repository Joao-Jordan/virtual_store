import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:virtual_store/screens/home_screen.dart';
import 'package:virtual_store/screens/signup_screen.dart';
import 'package:virtual_store/service/tab_service.dart';
import 'firebase_options.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtual Store',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AuthService().handleAuthState(),
    );
  }
}