import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/data/product.dart';
import 'package:flutter_application_1/data/product_api.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductApi productApi;

  ProductCubit(this.productApi) : super(ProductInitial());

  void getProducts() async {
    emit(LoadingProduct());
    var result = await productApi.getProducts();
    result.fold(
      (errorMessage) => emit(FailureLoadAllProduct(errorMessage)),
      (product) => emit(SuccessLoadAllProduct(product)),
    );
  }

  void postProducts(ProductApi productApi) async {
    emit(LoadingProduct());
    var result = await productApi.postProducts(productApi);
    result.fold(
      (errorMessage) => emit(FailureSubmitProduct(errorMessage)),
      (_) => emit(SuccessSubmitProduct()),
    );
  }

  void putProductById(ProductApi productApi, int id) async {
    emit(LoadingProduct());
    var result = await productApi.putProductById(id, productApi);
    result.fold(
      (errorMessage) => emit(FailureSubmitProduct(errorMessage)),
      (_) => emit(SuccessSubmitProduct()),
    );
  }

  void deleteProductById(int id) async {
    emit(LoadingProduct());
    var resultDelete = await productApi.deleteProductById(id);
    var resultDeleteFold = resultDelete.fold(
      (errorMessage) => errorMessage,
      (response) => response,
    );
    if (resultDeleteFold is String) {
      emit(FailureDeleteProduct(resultDeleteFold));
      return;
    }
    var resultgetProducts = await productApi.getProducts();
    resultgetProducts.fold(
      (errorMessage) => emit(FailureLoadAllProduct(errorMessage)),
      (_productsList) => emit(
        SuccessLoadAllProduct(
          _productsList,
          message: 'Peoduct data deleted successfully',
        ),
      ),
    );
  }
}
