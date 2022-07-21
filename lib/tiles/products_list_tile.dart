import 'package:flutter/material.dart';

import '../screens/product_screen.dart';

class ProductsListTile extends StatelessWidget {
  const ProductsListTile(this.categoryList, {Key? key}) : super(key: key);

  final Map<String, dynamic> categoryList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(categoryList['icon']),
          ),
          title: Text(categoryList['title']),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductScreen(categoryList),
              ),
            );
          },
        ),
      ],
    );
  }
}
