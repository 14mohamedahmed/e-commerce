import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/bottom_navy_bar.dart';
import 'package:shop_app/model/product/product.dart';
import 'package:shop_app/provider/cartProvider.dart';

class ItemDetails extends StatefulWidget {
  static const String routeName = '/itemDetails';

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
    final provider = Provider.of<CartProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    AppConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'product Description',
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: AppConfig.blockSizeVertical * 3,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: AppConfig.blockSizeVertical * 5,
                ),
                color: Colors.black.withOpacity(0.3),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BuildBottomNavyBar(
                        selectedIndex: 1,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  // color: Theme.of(context).accentColor,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${provider.totalCartItems}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  child: FlatButton(
                    color: Colors.deepOrangeAccent,
                    onPressed: () {},
                    child: Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppConfig.blockSizeVertical * 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    provider.addCartItemToCart(
                      id: product.id,
                      name: product.name,
                      price: product.price,
                      categoryName: product.categoryName,
                      imagePath: product.imagePath,
                    );
                  },
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.deepOrangeAccent,
                    size: AppConfig.blockSizeVertical * 3,
                  )),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height * 0.4,
                child: Hero(
                  tag: product.id,
                  child: Image.network(
                    product.imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: IconButton(
                    icon: Icon(
                      product.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product.isFavourite ? Colors.red : Colors.grey,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        product.isFavourite = !product.isFavourite;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          Container(
            child: Card(
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: AppConfig.blockSizeVertical * 3,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '\$ ${product.price}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppConfig.blockSizeVertical * 2.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: AppConfig.blockSizeVertical * 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      product.description,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: AppConfig.blockSizeVertical * 2.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
