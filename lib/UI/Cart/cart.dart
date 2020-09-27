import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/Cart/component/build_cart.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/cart/cart_item.dart';
import 'package:shop_app/provider/cartProvider.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    AppConfig().init(context);
    return FutureBuilder(
        future: cartProvider.fetchCartItem(),
        builder: (context, snapshot) => snapshot.hasData
            ? snapshot.data.length > 0
                ? buildCartBody(snapshot.data, context)
                : errorMessage()
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget buildCartBody(List<CartItem> product, BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: product.length,
        itemBuilder: (context, index) => BuildCart(
          product: product[index],
        ),
      ),
    );

    // Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: <Widget>[
    //     Expanded(
    //       child:
    //     ),
    //
    //
    //
    // Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height * 0.07,
    //   child: Card(
    //     elevation: 5.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12.0),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //       child: Row(
    //         children: <Widget>[
    //           Text(
    //             'Total Price ',
    //             style: TextStyle(
    //               color: Colors.black,
    //               fontSize: 20,
    //             ),
    //           ),
    //           Spacer(),
    //           Consumer<CartProvider>(
    //             builder: (ctc, cart, _) => Container(
    //               height: MediaQuery.of(context).size.height * 0.05,
    //               width: MediaQuery.of(context).size.width * 0.16,
    //               decoration: BoxDecoration(
    //                 color: Colors.brown.shade500,
    //                 borderRadius: BorderRadius.circular(12.0),
    //               ),
    //               child: Center(
    //                 child: FittedBox(
    //                   child: Text(
    //                     '\$${cart.totalPrice} ',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           FlatButton(
    //             onPressed: () {
    //               print('path it to order Page');
    //             },
    //             child: Text(
    //               'ORDER NOW',
    //               style: TextStyle(color: Colors.blue, fontSize: 17),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    //   ],
    // );
  }

  Widget errorMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Sorry!! you dont have any item yet!...\nplease add some',
          style: TextStyle(fontSize: AppConfig.blockSizeVertical * 3),
        ),
      ),
    );
  }
}
