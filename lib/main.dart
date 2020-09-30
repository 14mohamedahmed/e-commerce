import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/UI/Category/category_product.dart';
import 'package:shop_app/UI/DetailsPage/item_details.dart';
import 'package:shop_app/UI/auth/authentication.dart';
import 'package:shop_app/UI/orders/order.dart';
import 'package:shop_app/bottom_navy_bar.dart';
import 'package:shop_app/provider/auth_provider.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/categories.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/provider/user_provider.dart';

var keepLoggedIn;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences getUser = await SharedPreferences.getInstance();
  keepLoggedIn = getUser.getString('userEmail');
  print('name=================$keepLoggedIn');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.deepOrangeAccent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: keepLoggedIn == null || keepLoggedIn == ''
            ? Authentication()
            : BuildBottomNavyBar(selectedIndex: 0),
        routes: {
          BuildBottomNavyBar.routeName: (context) =>
              BuildBottomNavyBar(selectedIndex: 0),
          ItemDetails.routeName: (context) => ItemDetails(),
          CategoryProduct.routeName: (context) => CategoryProduct(),
          Orders.routeName: (context) => Orders(),
        },
      ),
    );
  }
}
