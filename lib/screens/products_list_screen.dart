import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../tiles/products_list_tile.dart';

class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({Key? key}) : super(key: key);

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: db.collection('products').orderBy('title').get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List categoryList = snapshot.data!.docs.toList();

        return ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            //ProductsTile(productsIcons, productsTitle)
            return ProductsListTile(categoryList[index].data());
          },
        );
      },
    );
  }

}