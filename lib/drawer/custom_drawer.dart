import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/drawer/drawer_tabs.dart';
import '../models/user_model.dart';
import '../screens/login_screen.dart';

class CustomDrawer extends StatefulWidget {
  final PageController pageController;

  const CustomDrawer({Key? key, required this.pageController}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? userName;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Drawer(
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Stack(
            children: [
              _buildDrawerBack(),
              ListView(
                padding: const EdgeInsets.only(left: 15, top: 15),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                    height: 165,
                    child: Stack(
                      children: [
                        const Positioned(
                          top: 8,
                          left: 0,
                          child: Text(
                            'Virtual\nStore',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 95,
                            left: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Olá, ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                _showUserName(model, size)
                              ],
                            )),
                      ],
                    ),
                  ),
                  const Divider(),
                  //DrawerTile(icon, text, controller, page)
                  DrawerTabs(
                    Icons.home,
                    'Início',
                    widget.pageController,
                    0,
                  ),
                  DrawerTabs(
                    Icons.list,
                    'Produtos',
                    widget.pageController,
                    1,
                  ),
                  DrawerTabs(
                    Icons.location_on,
                    'Lojas',
                    widget.pageController,
                    2,
                  ),
                  DrawerTabs(
                    Icons.playlist_add_check,
                    'Meus Pedidos',
                    widget.pageController,
                    3,
                  ),
                  _showLogOutButton(model, size)
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerBack() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 180, 255, 255),
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
    );
  }

  _showUserName(model, size) {
    if (!model.isLoggedIn()) {
      return TextButton(
        child: Text(
          'Entre ou cadastre-se',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      );
    }
    return Text(
      model.user.email,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  _showLogOutButton(model, size) {
    if (!model.isLoggedIn()) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.only(left: 55, right: 65, top: size.height * 0.4),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          child: const Text(
            'Sair',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              model.signOut();
            });
          },
        ),
      ),
    );
    }
  }

