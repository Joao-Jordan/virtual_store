import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../service/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Store'),
        actions: [
          IconButton(onPressed: (){
            AuthService().signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        color: Colors.blue,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeScreen',
              style: TextStyle(fontSize: 50, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
