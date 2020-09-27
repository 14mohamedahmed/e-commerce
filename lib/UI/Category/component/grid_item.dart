import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/DetailsPage/item_details.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/product/product.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/categories.dart';

class GridItem extends StatefulWidget {
  final Product product;
  final String categoryName;
  const GridItem({this.product, this.categoryName});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ItemDetails.routeName, arguments: widget.product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        shadowColor: Colors.orange[900],
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: widget.product.id,
                        child: Image.network(
                          widget.product.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Consumer<Categories>(
                          builder: (ctx, prod, _) => IconButton(
                            icon: Icon(
                              widget.product.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.product.isFavourite
                                  ? Colors.red
                                  : Colors.grey,
                              size: 35,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.product.isFavourite =
                                    !widget.product.isFavourite;
                              });
                              Provider.of<Categories>(context, listen: false)
                                  .addFavouriteProduct(widget.product.id,
                                      widget.product.isFavourite);
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.grey,
                            size: 35,
                          ),
                          onPressed: () {
                            provider
                                .addCartItemToCart(
                              id: widget.product.id,
                              name: widget.product.name,
                              price: widget.product.price,
                              categoryName: widget.product.categoryName,
                              imagePath: widget.product.imagePath,
                            )
                                .whenComplete(() {
                              if (index == 0) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('added to cart succefully'),
                                  duration: Duration(milliseconds: 800),
                                ));
                                setState(() {
                                  index = 1;
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('product alread in cart'),
                                  duration: Duration(milliseconds: 800),
                                ));
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 10),
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: AppConfig.blockSizeVertical * 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 10),
                child: Text(
                  '\$${widget.product.price}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppConfig.blockSizeVertical * 2.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
