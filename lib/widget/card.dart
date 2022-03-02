// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/product_api.dart';
import 'package:flutter_application_1/data/product.dart';

//callback
typedef OnDeletedProduct = Function();
typedef OnEditProduct = Function(Product product);
typedef OnTapProduct = Function(Product product);

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.product,
    this.onEditProduct,
    this.onDeletedProduct,
    this.onTapProduct,
  }) : super(key: key);

  final Product product;
  final OnEditProduct onEditProduct;
  final OnDeletedProduct onDeletedProduct;
  final OnTapProduct onTapProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onTapProduct(product);
        },
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.arrow_drop_down_circle),
              title: Text(product.name),
              subtitle: Text(
                "Rp ${product.price.toString()}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  onPressed: () {
                    onEditProduct(product);
                  },
                  child: const Text('Edit'),
                ),
                FlatButton(
                  onPressed: () {
                    final dialog = AlertDialog(
                      title: const Text('Delete?'),
                      content: const Text('This will delete your book.'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL'),
                        ),
                        FlatButton(
                          onPressed: () async {
                            try {
                              final bool deleted = await ProductApi()
                                  .deleteProductById(product.id);
                              if (deleted) {
                                onDeletedProduct();
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: const Text('ACCEPT'),
                        ),
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (context) => dialog,
                    );
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
