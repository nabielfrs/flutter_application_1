import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/product.dart';

class Detail extends StatelessWidget {
  static const String route = "/detail";

  final Product? product;
  const Detail({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              CachedNetworkImage(imageUrl: product!.imageUrl),
              Text(
                product!.name,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                product!.description,
                style: TextStyle(fontSize: 12),
              ),
              Text(
                " ${product!.price.toString()}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
