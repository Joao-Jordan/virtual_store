import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<QuerySnapshot<Map<String, dynamic>>> homeImages = FirebaseFirestore.instance.collection('home').orderBy('pos').get();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBodyBack(), //background
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Novidades'),
                centerTitle: true,
              ),
            ),
            FutureBuilder(
              future: homeImages,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  );
                }
                return SliverGrid(
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 2,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: const [
                      QuiltedGridTile(2, 2),
                      QuiltedGridTile(1, 1),
                    ],
                  ),
                  delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.data!.docs[index]['image'],
                          fit: BoxFit.cover,
                        );
                      },
                      childCount: snapshot.data.docs.length
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  //Função responsavel pelo background gradiente
  Widget _buildBodyBack() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 180, 255, 255),
            Colors.white,
          ],
        ),
      ),
    );
  }
}
