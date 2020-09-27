import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/orders/component/order_cart.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/order/order_model.dart';
import 'package:shop_app/provider/order_provider.dart';

class Orders extends StatelessWidget {
  static final String routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    final provider = Provider.of<OrderProvider>(context, listen: false);
    provider.fetchOrders();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: AppConfig.blockSizeVertical * 3),
        ),
      ),
      body: FutureBuilder(
        future: provider.fetchOrders(),
        builder: (context, snapshot) => snapshot.hasData
            ? snapshot.data.length > 0
                ? buildOrderBody(snapshot.data)
                : errorMessage()
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget buildOrderBody(List<OrderModel> orderProducts) {
    return ListView.builder(
      itemCount: orderProducts.length,
      itemBuilder: (context, index) => OrderCart(
        order: orderProducts[index],
      ),
    );
  }

  Widget errorMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text('Sorry!! you dont have any order yet!... please make some'),
      ),
    );
  }
}
