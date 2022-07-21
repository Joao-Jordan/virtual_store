import 'package:flutter/material.dart';
import 'package:virtual_store/screens/home_screen.dart';
import 'package:virtual_store/screens/products_list_screen.dart';
import '../drawer/custom_drawer.dart';

class TabService extends StatefulWidget {
  const TabService({Key? key}) : super(key: key);

  @override
  State<TabService> createState() => _TabServiceState();
}

class _TabServiceState extends State<TabService> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: const HomeScreen(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Produtos'),
            centerTitle: true,
          ),
          body: ProductsListScreen(),
          drawer: CustomDrawer(pageController: _pageController),
        )
      ],
    );
  }
}
