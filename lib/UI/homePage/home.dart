import 'package:flutter/material.dart';
import 'package:shop_app/UI/homePage/component/app_bar.dart';
import 'package:shop_app/UI/homePage/component/build_category_list_view.dart';
import 'package:shop_app/UI/homePage/component/build_product_grid_view.dart';
import 'package:shop_app/UI/homePage/component/carsoul_slider.dart';
import 'package:shop_app/appConfig/app_config.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //build app bar
            BuildAppBar(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  //build carsoul images
                  BuildCarsoulSlider(),
                  // build category text
                  buildTitleField(
                      title: 'Categories',
                      size: AppConfig.blockSizeVertical * 3),
                  // build Grid View Items
                  BuildCategoryListView(),
                  //  build recommended text
                  buildTitleField(
                      title: 'Recommended',
                      size: AppConfig.blockSizeVertical * 3),
                  //build recommended products
                  BuildProductGridView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitleField({String title, double size}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
