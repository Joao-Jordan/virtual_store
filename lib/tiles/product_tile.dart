import 'package:flutter/material.dart';
import '../screens/item_screen.dart';


class ProductTile extends StatelessWidget {
  const ProductTile(this.type, this.itemsList, {Key? key}) : super(key: key);

  final String type;
  final Map<String, dynamic> itemsList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: type == 'grid'
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                itemsList['images'][0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Text(
                      itemsList['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'R\$${itemsList['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            : Row(
          children: [
            Flexible(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(
                  itemsList['images'][0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemsList['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'R\$${itemsList['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Theme
                                .of(context)
                                .primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(itemsList['description'])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemScreen(itemsList)));
      },
    );
  }
}
