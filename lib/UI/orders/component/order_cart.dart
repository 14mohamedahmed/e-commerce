import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/order/order_model.dart';

class OrderCart extends StatefulWidget {
  final OrderModel order;
  OrderCart({this.order});

  @override
  _OrderCartState createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> with TickerProviderStateMixin {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 6,
      shadowColor: Colors.orange[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(
          widget.order.categoryName,
          style: TextStyle(
              color: Colors.black, fontSize: AppConfig.blockSizeVertical * 2.5),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat('kk:mm:ss / yyyy-MM-dd').format(widget.order.dateTime),
              style: TextStyle(
                color: Colors.black,
                fontSize: AppConfig.blockSizeVertical * 2.5,
              ),
            ),
            if (showDetails)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: width * 0.5,
                        child: Text(
                          widget.order.name,
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: AppConfig.blockSizeVertical * 3,
                          ),
                        ),
                      ),
                      Text(
                        '     x${widget.order.quantity}',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: AppConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$${widget.order.price}',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: AppConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              showDetails = !showDetails;
            });
          },
          child: showDetails
              ? Icon(Icons.keyboard_arrow_up)
              : Icon(Icons.keyboard_arrow_down),
        ),
      ),
    );
  }
}
