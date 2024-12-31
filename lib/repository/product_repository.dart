import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProduct() async {
    try {
      String url = 'https://fakestoreapi.in/api/products';

      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      final body = json.decode(response.body)['products'] as List;

      if (kDebugMode) {
        print(response.statusCode.toString());

        print(body);
      }

      if (response.statusCode == 200) {
        var list = body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return Product(
            id: map['id'] as int,
            title: map['title'] as String,
            image: map['image'] as String,
            price: map['price'] as int,
            model: map['model'] as String,
            description: map['description'] as String,
          );
        }).toList();

        return list;
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('time out');
    }

    throw Exception('error fetching data');
  }
}
