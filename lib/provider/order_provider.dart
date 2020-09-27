import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/emvironment.dart';
import 'package:shop_app/model/order/order_model.dart';
import 'package:http/http.dart' as h;

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _order = new List<OrderModel>();
  List<OrderModel> get orders => _order;
  final _auth = FirebaseAuth.instance;
  int get totalaOrder => _order.length;
  Future<List<OrderModel>> addOrder({
    String id,
    String name,
    String categoryName,
    double price,
    int quantity,
  }) async {
    final User user = _auth.currentUser;
    final existProd = _order.indexWhere((element) => element.id == id);
    if (existProd == -1) {
      await h.post(Environment().url + '/Orders/${user.uid}.json',
          body: json.encode({
            'id': id,
            'name': name,
            'categoryName': categoryName,
            'price': price,
            'quantity': quantity,
            'dateTime': DateFormat('yyyy-MM-dd - kk-mm').format(DateTime.now()),
          }));
      _order.add(OrderModel(
        id: id,
        name: name,
        categoryName: categoryName,
        price: price,
        quantity: quantity,
        dateTime: DateTime.now(),
      ));
    }
    return null;
  }

  Future<List<OrderModel>> fetchOrders() async {
    final User user = _auth.currentUser;
    final response =
        await h.get(Environment().url + '/Orders/${user.uid}.json');
    List<OrderModel> _loadedOrder = [];
    final existOrders = json.decode(response.body) as Map<String, dynamic>;
    if (existOrders != null) {
      existOrders.forEach((orderID, orderData) {
        _loadedOrder.add(
          OrderModel(
            id: orderID,
            name: orderData['name'],
            categoryName: orderData['categoryName'],
            price: orderData['price'],
            quantity: orderData['quantity'],
            dateTime:
                DateFormat('yyyy-MM-dd - kk-mm').parse(orderData['dateTime']),
          ),
        );
      });
    }
    _order = _loadedOrder;
    return _loadedOrder;
  }
}
