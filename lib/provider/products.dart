import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as h;
import 'package:shop_app/emvironment.dart';
import 'package:shop_app/model/product/product.dart';

class Products extends ChangeNotifier {
  List<Product> _products = [
    Product(
      id: '1',
      name: 'Blazer',
      description: 'Black Blazer, size is large, good Blazer',
      price: 149.99,
      imagePath: 'assets/products/blazer1.jpeg',
      isFavourite: false,
    ),
    Product(
        id: '2',
        name: 'Dress',
        description: 'Black Dress, size is large, good Dress',
        price: 149.99,
        imagePath: 'assets/products/dress1.jpeg',
        isFavourite: false),
    Product(
        id: '3',
        name: 'Hill',
        description: 'Black Hill, size is large, good Hill',
        price: 149.99,
        imagePath: 'assets/products/hills1.jpeg',
        isFavourite: false),
    Product(
        id: '4',
        name: 'Pants',
        description: 'Black Pants, size is large, good Pants',
        price: 149.99,
        imagePath: 'assets/products/pants1.jpg',
        isFavourite: false),
    Product(
      id: '5',
      name: 'Skt',
      description: 'Black skt, size is large, good skt',
      price: 149.99,
      imagePath: 'assets/products/skt1.jpeg',
      isFavourite: false,
    ),
  ];
  List<Product> get getProducts => _products;

  Future<void> addProduct(String title, String description, double price,
      String imagePath, String categoryName) async {
    try {
      await h.post(
        Environment().url + 'Products.json',
        body: json.encode(
          {
            'id': DateTime.now().toString(),
            'name': title,
            'description': description,
            'price': price,
            'imagePath': imagePath,
            'isFavourite': Product().isFavourite,
            'CategoryName': categoryName,
          },
        ),
      );
      final newProduct = Product(
        id: DateTime.now().toString(),
        name: title,
        description: description,
        price: price,
        imagePath: imagePath,
      );
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
