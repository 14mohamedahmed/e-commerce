import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/emvironment.dart';
import 'package:shop_app/model/category/category.dart';
import 'package:http/http.dart' as h;
import 'package:shop_app/model/product/product.dart';

class Categories extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  List<Product> _products = [];
  List<Product> get products => _products;
  Future<List<Category>> fetchCategories() async {
    final response = await h.get(Environment().url + 'Categories.json');
    final List<Category> _loadedCategory = [];
    final extreactData = json.decode(response.body) as Map<String, dynamic>;
    extreactData.forEach((prodID, prodData) {
      _loadedCategory.add(
        Category(
          id: prodID,
          name: prodData['name'],
        ),
      );
    });
    return _loadedCategory;
  }

  Future<List<Product>> fetchProductsByCategoryName(String categoryName) async {
    final User user = _auth.currentUser;
    final response =
        await h.get(Environment().url + 'Products/$categoryName.json');
    final List<Product> _loadedProduct = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final favouriteresponse =
        await h.get(Environment().url + 'FavoriteProducts/${user.uid}.json');
    final favouriteData = json.decode(favouriteresponse.body);
    if (extractedData != null)
      extractedData.forEach((prodID, prodData) {
        _loadedProduct.add(
          Product(
            id: prodID,
            name: prodData['name'],
            categoryName: categoryName,
            description: prodData['description'],
            imagePath: prodData['imagePath'],
            price: prodData['price'].toDouble(),
            isFavourite:
                favouriteData == null ? false : favouriteData[prodID] ?? false,
          ),
        );
      });
    _products = _loadedProduct;
    return _loadedProduct;
  }

  Future<void> addFavouriteProduct(String id, bool favoutire) async {
    final User user = _auth.currentUser;

    try {
      final resposne = await h.put(
        Environment().url + 'FavoriteProducts/${user.uid}/$id.json',
        body: json.encode(
          favoutire,
        ),
      );
      if (resposne.statusCode >= 400) {
        print(resposne.statusCode);
        print('respone');
        notifyListeners();
      }
    } catch (error) {
      print(error);
      notifyListeners();
    }
  }

  // Future<void> updateProductFavourite(
  //     String categoryName, String prodId) async {
  //   var isFavorite;
  //   final _prodIndex = _products.indexWhere((element) {
  //     isFavorite = !element.isFavourite;
  //     return element.id == prodId;
  //   });
  //   print(isFavorite);
  //   if (_prodIndex >= 0) {
  //     try {
  //       await h.patch(
  //         Environment().url + 'Products/$categoryName/$prodId.json',
  //         body: json.encode(
  //           [
  //             {
  //               'isFavourite': isFavorite,
  //             },
  //           ],
  //         ),
  //       );
  //       notifyListeners();
  //     } catch (error) {
  //       print(error);
  //       notifyListeners();
  //     }
  //   } else {
  //     print('product dose not exist');
  //   }
  // }
}
