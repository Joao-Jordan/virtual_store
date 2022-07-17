import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtual_store/screens/home_screen.dart';

import 'auth_service.dart';

class TabService extends StatefulWidget {
  TabService({Key? key}) : super(key: key);

  @override
  State<TabService> createState() => _TabServiceState();
}

class _TabServiceState extends State<TabService> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      //controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: const HomeScreen(),
          //drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
