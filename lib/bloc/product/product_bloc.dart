import 'package:bloc/bloc.dart';


import '../../repository/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository = ProductRepository();

  ProductBloc() : super(ProductState()) {
    on<ProductFetched>(fetchProductApi);
    on<ProductDetailFetched>(fetchProductDetails);
  }

  Future<void> fetchProductApi(
      ProductFetched event, Emitter<ProductState> emit) async {
    await productRepository.fetchProduct().then((value) {
      // print('bloc value: $value');
      emit(state.copyWith(
          status: ProductStatus.success,
          productList: value,
          message: 'success'));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: ProductStatus.failure, message: error.toString()));
      print('bloc error: $error');
      print('bloc value: $stackTrace');
    });
  }

  Future<void> fetchProductDetails(
      ProductDetailFetched event, Emitter<ProductState> emit) async {


 try {
        emit(state.copyWith(status: ProductStatus.initial));
        // Assuming you fetch data from a repository:
        final product = state.products[event.productId];
        emit(state.copyWith(
          status: ProductStatus.success,
          selectedProduct: product,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          message: e.toString(),
        ));
      }
    // emit(state.copyWith(productId: event.productId));
    // print('product idr: ${event.productId}');


  }


}
