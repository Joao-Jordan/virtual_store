import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen(this.itemsList, {Key? key}) : super(key: key);

  final Map<String, dynamic> itemsList;

  @override
  State<ItemScreen> createState() => _ItemScreenState(itemsList);
}

class _ItemScreenState extends State<ItemScreen> {
  final Map<String, dynamic> itemsList;

  _ItemScreenState(this.itemsList);

  int _current = 0;
  String? size;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    List itemImageList = itemsList['images'].toList();
    List itemSizeList = itemsList['sizes'].toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(itemsList['title']),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 9 / 16,
                viewportFraction: 1,
                autoPlay: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              itemCount: itemImageList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final urlImage = itemImageList[index];
                return buildImage(urlImage, index);
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: buildDotIndicator(itemImageList),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 17, right: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  itemsList['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${itemsList['price'].toStringAsFixed(2)}',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tamanho',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(4),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    itemCount: itemSizeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              color: itemSizeList[index] == size
                                  ? primaryColor
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            itemSizeList[index],
                            style: TextStyle(
                              color: itemSizeList[index] == size
                                  ? primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            size = itemSizeList[index];
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    child: const Text('Adicionar ao Carrinho', style: TextStyle(fontSize: 18)),
                    onPressed: size != null ? () {} : null,
                  ),
                ),
                const SizedBox(height: 12,),
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(itemsList['description'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, index) {
    return SizedBox(
      //margin: const EdgeInsets.only(top: 5),
      width: double.infinity,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildDotIndicator(itemImageList) {
    return AnimatedSmoothIndicator(
      activeIndex: _current,
      count: itemImageList.length,
      effect: JumpingDotEffect(
          dotColor: Colors.grey,
          activeDotColor: Theme
              .of(context)
              .primaryColor,
          dotHeight: 7,
          dotWidth: 7),
    );
  }
}
