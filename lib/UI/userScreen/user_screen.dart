import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/auth/authentication.dart';
import 'package:shop_app/UI/orders/order.dart';
import 'package:shop_app/UI/userScreen/component/build_setting_card.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/provider/auth_provider.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<AuthProvider>(context, listen: false);
    AppConfig().init(context);
    return SafeArea(
      top: true,
      child: FutureBuilder(
          future: provider.getUserInfo(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: width,
                        height: height * 0.34,
                        child: Image.asset(
                          'assets/bgImage.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: height * 0.4,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/bgImage.png'),
                          backgroundColor: Colors.white,
                          radius: width * 0.15,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: width,
                      height: height * 0.05,
                      alignment: Alignment.center,
                      child: Text(
                        provider.getUserName ?? 'Loading...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppConfig.blockSizeVertical * 3,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Orders.routeName);
                          },
                          child: Container(
                            child: BuildSettingCard(
                                icon: Icons.add_shopping_cart,
                                title: 'My Orders'),
                          ),
                        ),
                        BuildSettingCard(
                            icon: Icons.settings, title: 'Setting'),
                        BuildSettingCard(
                            icon: Icons.phone_android, title: 'About App'),
                        GestureDetector(
                            onTap: () {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .signOut()
                                  .then((value) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Authentication()));
                              });
                              Provider.of<AuthProvider>(context, listen: false)
                                  .clearUserInfo();
                            },
                            child: BuildSettingCard(
                                icon: Icons.exit_to_app, title: 'Sign Out')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
