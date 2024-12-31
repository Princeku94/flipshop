
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductFetched extends ProductEvent {}


class ProductDetailFetched extends ProductEvent {
  final int productId;

  ProductDetailFetched({required this.productId});
}



