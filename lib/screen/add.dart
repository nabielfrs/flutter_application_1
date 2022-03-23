import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/product_cubit.dart';
import 'package:flutter_application_1/data/product_api.dart';
import 'package:flutter_application_1/data/product.dart';

class AddEditProduct extends StatefulWidget {
  static const String routeAdd = "/add";
  static const String routeEdit = "/edit";
  final bool Add;
  Product product;

  AddEditProduct({
    Key key,
    this.Add,
    this.product,
  }) : super(key: key);

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final formKey = GlobalKey<FormState>();
  final productCubit = ProductCubit(ProductApi());

  String bookName;
  String bookDescription;
  String imageUrl;
  double bookPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Add ? "Add New Product" : "Edit Product"),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context, widget.product);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();

                if (widget.Add) {
                  ProductApi().postProducts({
                    "name": bookName,
                    "description": bookDescription,
                    "price": bookPrice,
                    "img": "Link/$bookName",
                  }).then((value) {
                    formKey.currentState.reset();
                    Navigator.pop(context, value);
                  });
                } else {
                  ProductApi().putProductById(widget.product.id, {
                    "name": bookName,
                    "description": bookDescription,
                    "price": bookPrice,
                    "img": imageUrl,
                  }).then((value) {
                    formKey.currentState?.reset();
                    Navigator.pop(context, value);
                  });
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Book Title"),
                initialValue: widget.Add ? null : widget.product.name,
                onSaved: (newValue) => bookName = newValue,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Book Description"),
                initialValue: widget.Add ? null : widget.product.description,
                onSaved: (newValue) => bookDescription = newValue,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Book Price"),
                initialValue:
                    widget.Add ? null : widget.product.price.toString(),
                onSaved: (newValue) => bookPrice = double.tryParse(newValue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
