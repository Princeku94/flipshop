import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../components/list_item.dart';
import '../config/routes/routes_name.dart';
import '../utils/colors/colors.dart';
import '../utils/constants.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({super.key});

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyColor,
        appBar: getAppBar(title: 'FlipShop', context: context, actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.musicScreen);
              },
              icon: Icon(
                Icons.music_note,
                color: Colors.red,
                size: 28,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.profileScreen);
              },
              icon: Icon(
                Icons.person_2_outlined,
                color:AppColors.blueColor,
                size: 28,
              )),
        ]),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          switch (state.status) {
            case ProductStatus.initial:
              return Center(child: CircularProgressIndicator());
            case ProductStatus.failure:
              return Center(child: Text(state.message.toString()));
            case ProductStatus.success:
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: ListView.builder(
                    itemCount:
                        state.products.isNotEmpty ? state.products.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.products.isNotEmpty) {
                        final product = state.products[index];
                        return ListItem(
                          image: product.image!,
                          title: product.title.toString(),
                          model: product.model.toString(),
                          price: product.price.toString(),
                          onTap: () {
                            context
                                .read<ProductBloc>()
                                .add(ProductDetailFetched(productId: index));
                            Navigator.pushNamed(
                                context, RoutesName.productDetailScreen);
                          },
                        );
                      } else {
                        return Center(child: Text('No products'));
                      }
                    },
                  ));
          }
        }));
  }
}
