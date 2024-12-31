import 'package:equatable/equatable.dart';

import '../../models/product.dart';

enum ProductStatus { initial, success, failure }

class ProductState extends Equatable {
  ProductState({
    this.selectedProduct,
    this.status = ProductStatus.initial,
    this.products = const <Product>[],
    this.message = '',
  });

  final ProductStatus status;
  final List<Product> products;

  final String message;
  final Product? selectedProduct;

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? productList,
    String? message,
    Product? selectedProduct,
  }) {
    return ProductState(
        status: status ?? this.status,
        products: productList ?? this.products,
        message: message ?? this.message,
        selectedProduct: selectedProduct ?? this.selectedProduct);
  }

  @override
  List<Object> get props => [status, products, message, ];
}
