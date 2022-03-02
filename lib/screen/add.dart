import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/product_api.dart';
import 'package:flutter_application_1/data/product.dart';

class AddEditProduct extends StatefulWidget {
  static const String routeAdd = "/add";
  static const String routeEdit = "/edit";
  final bool Add;
  Product? product;

  AddEditProduct({
    Key? key,
    required this.Add,
    this.product,
  }) : super(key: key);

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final formKey = GlobalKey<FormState>();

  late String bookName;
  late String bookDescription;
  late int bookPrice;

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
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                if (widget.Add) {
                  ProductApi().postProducts({
                    "name": bookName,
                    "description": bookDescription,
                    "price": bookPrice,
                    "image": "Link/$bookName",
                  }).then((value) {
                    formKey.currentState!.reset();
                    Navigator.pop(context, value);
                  });
                } else {
                  ProductApi().putProductById(widget.product!.id, {
                    "name": bookName,
                    "price": bookPrice,
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
                decoration: InputDecoration(labelText: "Book Title"),
                initialValue: widget.Add ? null : widget.product!.name,
                onSaved: (newValue) => bookName = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Book Description"),
                initialValue: widget.Add ? null : widget.product!.description,
                onSaved: (newValue) => bookDescription = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Book Price"),
                initialValue:
                    widget.Add ? null : widget.product!.price.toString(),
                onSaved: (newValue) => bookPrice = int.tryParse(newValue!)!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
