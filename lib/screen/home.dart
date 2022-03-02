import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/product_api.dart';
import 'package:flutter_application_1/data/product.dart';
import 'package:flutter_application_1/screen/add.dart';
import 'package:flutter_application_1/screen/detail.dart';

import '../widget/card.dart';

class Home extends StatefulWidget {
  static const String route = "/";

  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  late Future<List<Product>> _products;
  late List<Product> _productsList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _products = ProductApi().getProducts();
    _productsList = <Product>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _products = ProductApi().getProducts();
          });
        },
        child: FutureBuilder(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (_productsList.isEmpty) {
                //add data for first time
                _productsList =
                    (snapshot.data as List<Product>).toList(growable: true);
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: _productsList.length,
                itemBuilder: (context, index) => ProductCard(
                  product: _productsList[index],
                  onTapProduct: (product) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AddEditProduct(
                    //         product: product,
                    //       ),
                    //     ));
                  },
                  onEditProduct: (product) async {
                    final Product product = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditProduct(
                            Add: false,
                            product: _productsList[index],
                          ),
                        ));
                    setState(() {
                      _productsList[index] = product;
                    });
                  },
                  onDeletedProduct: () {
                    setState(() {
                      _productsList.removeAt(index);
                    });
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Product product = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditProduct(Add: true),
              ));
          if (product != null) {
            setState(() {
              _productsList.add(product);
            });
          }
        },
        elevation: 2.0,
        child: Icon(Icons.add),
      ),
    );
  }
}
