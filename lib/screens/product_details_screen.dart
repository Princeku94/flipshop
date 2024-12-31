import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../utils/colors/colors.dart';
import '../utils/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // late ProductBloc _productBloc;
  late int productId;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetched());
    //_productBloc = ProductBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: getAppBar(title: 'Product Details', context: context),
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        switch (state.status) {
          case ProductStatus.initial:
            return Center(child: CircularProgressIndicator());
          case ProductStatus.failure:
            return Center(child: Text(state.message.toString()));
          case ProductStatus.success:
            final product = state.selectedProduct;
            if (product == null) {
              return Center(child: Text('No product details available'));
            }
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Hero(
                  tag: product.title!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45)),
                    child: CachedNetworkImage(
                      imageUrl: product.image!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.title!,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        product.model!,
                        maxLines: 1,
                      ),
                      Text(
                        '⭐ ⭐ ⭐ ⭐ ⭐',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Rs.${product.price!}',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w900),
                        maxLines: 1,
                      ),
                      Divider(
                        color: Colors.blue,
                      ),
                      Text(
                        'Product Details:',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        product.description!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
        }
      }),
    );
  }
}
