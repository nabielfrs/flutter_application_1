import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/product.dart';

class ProductApi {
  final _dio = Dio();
  final String _baseUrl = "http://localhost:3000";

  Future<List<Product>> getProducts() async {
    try {
      final Response response = await _dio.get("$_baseUrl/products");
      final results = Map<String, dynamic>.from(response.data);
      return (results as List)
          .map((e) => Product.fromMap(e))
          .toList(growable: false);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final Response response = await _dio.get("$_baseUrl/products/$id");
      final results = Map<String, dynamic>.from(response.data);
      return Product.fromMap(results);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> postProducts(body) async {
    try {
      final Response response = await _dio.post(
        "$_baseUrl/products",
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final results = Map<String, dynamic>.from(response.data);
      return Product.fromMap(results);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> putProductById(id, body) async {
    try {
      final Response response = await _dio.put(
        "$_baseUrl/products/$id",
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final results = Map<String, dynamic>.from(response.data);
      return Product.fromMap(results);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> deleteProductById(id) async {
    try {
      final Response response = await _dio.delete("$_baseUrl/products/$id");
      final resutls = Map<String, dynamic>.from(response.data);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
