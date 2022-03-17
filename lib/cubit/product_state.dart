part of 'product_cubit.dart';

@immutable
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
  final List<Product> product;
  final String message;

  SuccessLoadAllProduct(this.product, {this.message});

  @override
  String toString() {
    return 'SuccessLoadAllProduct{product: $product, message: $message}';
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
