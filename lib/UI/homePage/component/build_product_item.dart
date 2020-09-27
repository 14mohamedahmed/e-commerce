import 'package:flutter/material.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/product/product.dart';

class BuildProductItem extends StatelessWidget {
  final Product product;
  final int index;

  const BuildProductItem({this.product, this.index});

  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        print('Nothing ToDO....');
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: index.isOdd
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: height,
              width: width,
              child: Hero(
                tag: product.id,
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  width: width / 2,
                  decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      )),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: AppConfig.blockSizeVertical * 2.7,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: AppConfig.blockSizeVertical * 2.6,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
