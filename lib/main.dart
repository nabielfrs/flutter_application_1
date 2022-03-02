import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/add.dart';
import 'package:flutter_application_1/screen/detail.dart';
import 'package:flutter_application_1/screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Home.route,
      routes: {
        Home.route: (context) => Home(),
        Detail.route: (context) => Detail(),
        AddEditProduct.routeAdd: (context) => AddEditProduct(
              Add: true,
            ),
        AddEditProduct.routeEdit: (context) => AddEditProduct(
              Add: false,
            ),
      },
    );
  }
}
