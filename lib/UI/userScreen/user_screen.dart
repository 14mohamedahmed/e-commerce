import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/auth/authentication.dart';
import 'package:shop_app/UI/orders/order.dart';
import 'package:shop_app/UI/userScreen/component/build_setting_card.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/provider/auth_provider.dart';
import 'package:shop_app/provider/user_provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    AppConfig().init(context);
    userProvider.fetchUserImage();
    return SafeArea(
      top: true,
      child: FutureBuilder(
          future: provider.getUserInfo(),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: userProvider.fetchUserImage(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : buildBody(provider, userProvider),
            );
          }),
    );
  }

  Widget buildBody(AuthProvider provider, UserProvider userProvider) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userprofile = userProvider.userImage[0].photoUrl;
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
                  backgroundImage: userprofile == null
                      ? AssetImage('assets/bgImage.png')
                      : NetworkImage(userprofile),
                  backgroundColor: Colors.grey[400],
                  radius: width * 0.15,
                ),
              ),
              Positioned(
                bottom: 0,
                left: width / 2 + width * 0.05,
                child: GestureDetector(
                  onTap: () {
                    userProvider.selectImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
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
                        icon: Icons.add_shopping_cart, title: 'My Orders'),
                  ),
                ),
                BuildSettingCard(icon: Icons.settings, title: 'Setting'),
                BuildSettingCard(icon: Icons.phone_android, title: 'About App'),
                GestureDetector(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut()
                          .then((value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Authentication()));
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
  }
}
