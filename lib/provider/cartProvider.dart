import 'package:flutter/cupertino.dart';
import 'package:shop_app/model/cart/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = new List<CartItem>();
  List<CartItem> get cartCartItems => _cartItems;
  int get totalCartItems => _cartItems.length;
  Future<List<CartItem>> fetchCartItem() async {
    return _cartItems;
  }

  double get totalPrice {
    double total = 0.0;
    _cartItems.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  Future<dynamic> addCartItemToCart(
      {String id,
      String name,
      String categoryName,
      double price,
      String imagePath,
      int quantity}) async {
    if (id == null) {
      print('product null');
      return true;
    }
    final existingCartItem = _cartItems.indexWhere((prod) => prod.id == id);
    if (existingCartItem == -1) {
      _cartItems.add(
        CartItem(
          id: id,
          name: name,
          categoryName: categoryName,
          imagePath: imagePath,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItemFromCart(String prodId) {
    _cartItems.removeWhere((element) => element.id == prodId);
    notifyListeners();
  }
}
