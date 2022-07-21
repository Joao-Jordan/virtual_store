import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../tiles/product_tile.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.categoryList, {Key? key}) : super(key: key);

  final Map<String, dynamic> categoryList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryList['title']),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('products').doc(categoryList['title']).collection('items').get()
          ,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List itemsList = snapshot.data!.docs.toList();

            return TabBarView(
              children: [
                GridView.builder(
                  padding: const EdgeInsets.all(4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductTile('grid', itemsList[index].data());
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    return ProductTile('list', itemsList[index].data());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}



