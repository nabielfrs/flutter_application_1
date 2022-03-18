import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/product_api.dart';
import 'package:flutter_application_1/data/product.dart';
import 'package:flutter_application_1/screen/add.dart';
import 'package:flutter_application_1/screen/detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_cubit.dart';

import '../cubit/product_state.dart';
import '../widget/card.dart';

class Home extends StatefulWidget {
  static const String route = "/";

  const Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  // Future<List<Product>> _products;
  // List<Product> _productsList;
  final ScrollController _scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  ProductCubit productCubit;

  @override
  void initState() {
    super.initState();
    productCubit = ProductCubit(ProductApi());
    productCubit.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD"),
      ),
      body: BlocProvider<ProductCubit>(
        create: (context) => productCubit,
        child: BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is FailureLoadAllProduct) {
              scaffoldState.currentState.showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state is FailureDeleteProduct) {
              scaffoldState.currentState.showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state is SuccessLoadAllProduct) {
              if (state.message != null && state.message.isNotEmpty)
                scaffoldState.currentState.showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
            }
          },
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: ((context, state) {
              if (state is LoadingProduct) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FailureLoadAllProduct) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is SuccessLoadAllProduct) {
                var _productsList = state.listproduct;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: _productsList.length,
                  itemBuilder: (context, index) => ProductCard(
                    product: _productsList[index],
                    onTapProduct: (product) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              product: product,
                            ),
                          ));
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
            }),
          ),
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
              productCubit.getProducts();
            });
          }
        },
        elevation: 2.0,
        child: Icon(Icons.add),
      ),
    );
  }
}
