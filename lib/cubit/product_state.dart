import 'package:flutter_application_1/data/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class LoadingProduct extends ProductState {}

class FailureLoadAllProduct extends ProductState {
  final String errorMessage;

  FailureLoadAllProduct(this.errorMessage);

  @override
  String toString() {
    return 'FailureLoadAllProduct{errorMessage: $errorMessage}';
  }
}

class SuccessLoadAllProduct extends ProductState {
  final List<Product> listproduct;
  final String message;

  SuccessLoadAllProduct(this.listproduct, {this.message});

  @override
  String toString() {
    return 'SuccessLoadAllProduct{product: $listproduct, message: $message}';
  }
}

class FailureSubmitProduct extends ProductState {
  final String errorMessage;

  FailureSubmitProduct(this.errorMessage);

  @override
  String toString() {
    return 'FailureSubmitProduct{errorMessage: $errorMessage}';
  }
}

class SuccessSubmitProduct extends ProductState {}

class FailureDeleteProduct extends ProductState {
  final String errorMessage;

  FailureDeleteProduct(this.errorMessage);

  @override
  String toString() {
    return 'FailureDeleteProduct{errorMessage: $errorMessage}';
  }
}
