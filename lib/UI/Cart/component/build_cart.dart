import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/cart/cart_item.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/order_provider.dart';

class BuildCart extends StatefulWidget {
  final CartItem product;
  BuildCart({this.product});

  @override
  _BuildCartState createState() => _BuildCartState();
}

class _BuildCartState extends State<BuildCart> {
  var productCount = 1;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<CartProvider>(context);
    AppConfig().init(context);
    return Dismissible(
      key: ValueKey(widget.product.id),
      background: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.red),
        padding: EdgeInsets.only(right: 30),
        child: Icon(
          Icons.delete,
          size: 35,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (duration) {
        provider.removeItemFromCart(widget.product.id);
      },
      child: Card(
        elevation: 6,
        shadowColor: Colors.orange[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      widget.product.imagePath,
                      height: height * 0.15,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.product.name,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: AppConfig.blockSizeVertical * 3,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            widget.product.categoryName,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: AppConfig.blockSizeVertical * 2.5,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            '\$${widget.product.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppConfig.blockSizeVertical * 2.7,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    AppConfig.blockSizeHorizontal * 1.5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orange,
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: AppConfig.blockSizeVertical * 2.7,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  iconSize: AppConfig.blockSizeVertical * 3,
                                  onPressed: () {
                                    if (widget.product.quantity != 1) {
                                      setState(() {
                                        widget.product.quantity--;
                                      });
                                    }
                                  },
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  '${widget.product.quantity}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: AppConfig.blockSizeVertical * 2.5,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  iconSize: AppConfig.blockSizeVertical * 3,
                                  onPressed: () {
                                    if (widget.product.quantity < 9) {
                                      setState(() {
                                        widget.product.quantity++;
                                      });
                                    }
                                  },
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: height * 0.002,
                color: Colors.grey,
                child: SizedBox(
                  width: width,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConfig.blockSizeHorizontal * 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Total Price: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppConfig.blockSizeVertical * 2.7,
                          ),
                        ),
                        Text(
                          '\$${widget.product.price * widget.product.quantity}',
                          style: TextStyle(
                            color: Colors.orange[900],
                            fontSize: AppConfig.blockSizeVertical * 2.7,
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<OrderProvider>(context, listen: false)
                            .addOrder(
                          id: widget.product.id,
                          name: widget.product.name,
                          categoryName: widget.product.categoryName,
                          price: widget.product.price * widget.product.quantity,
                          quantity: widget.product.quantity,
                        )
                            .then((value) {
                          provider.removeItemFromCart(widget.product.id);
                          setState(() {});
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Operation completed successfully')));
                        });
                      },
                      child: Text(
                        'Pay',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppConfig.blockSizeVertical * 3),
                      ),
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
