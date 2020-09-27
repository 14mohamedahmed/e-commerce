import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/UI/Cart/cart.dart';
import 'package:shop_app/UI/homePage/home.dart';
import 'package:shop_app/UI/userScreen/user_screen.dart';
import 'package:shop_app/appConfig/app_config.dart';

class BuildBottomNavyBar extends StatefulWidget {
  static final String routeName = '/navyBat';
  int selectedIndex;
  BuildBottomNavyBar({this.selectedIndex = 0});
  @override
  _BuildBottomNavyBarState createState() => _BuildBottomNavyBarState();
}

class _BuildBottomNavyBarState extends State<BuildBottomNavyBar> {
  List children = [
    Home(),
    Cart(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: widget.selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          widget.selectedIndex = index;
        }),
        animationDuration: Duration(milliseconds: 500),
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.home,
              size: AppConfig.blockSizeVertical * 2.7,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontSize: AppConfig.blockSizeVertical * 1.8),
            ),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: AppConfig.blockSizeVertical * 2.7,
              ),
              title: Text(
                'Cart',
                style: TextStyle(fontSize: AppConfig.blockSizeVertical * 1.8),
              ),
              activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(
                Icons.settings,
                size: AppConfig.blockSizeVertical * 2.7,
              ),
              title: Text(
                'Setting',
                style: TextStyle(fontSize: AppConfig.blockSizeVertical * 1.8),
              ),
              activeColor: Colors.purpleAccent),
        ],
      ),
      body: children[widget.selectedIndex],
    );
  }
}
