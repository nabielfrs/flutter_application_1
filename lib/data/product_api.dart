import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/product.dart';

class ProductApi {
  final _dio = Dio();
  final String _baseUrl = "http://localhost:3000";

  Future<Either<String, List<Product>>> getProducts() async {
    try {
      final Response response = await _dio.get("$_baseUrl/products");
      final results = response.data;
      var productData =
          List<Product>.from(response.data.map((e) => Product.fromMap(e)));
      return Right(productData);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  // Future<Product> getProductById(int id) async {
  //   try {
  //     final Response response = await _dio.get("$_baseUrl/products/$id");
  //     final results = response.data;
  //     return Product.fromMap(results);
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  Future<Either<String, bool>> postProducts(body) async {
    try {
      final Response response = await _dio.post(
        "$_baseUrl/products",
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final results = response.data;
      return const Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> putProductById(id, body) async {
    try {
      final Response response = await _dio.put(
        "$_baseUrl/products/$id",
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final results = response.data;

      return const Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, bool>> deleteProductById(id) async {
    try {
      final Response response = await _dio.delete("$_baseUrl/products/$id");
      final resutls = response.data;
      return const Right(true);
    } on DioError catch (error) {
      return Left('$error');
    }
  }
}
