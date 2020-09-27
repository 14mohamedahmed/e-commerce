import 'package:flutter/material.dart';
import 'package:shop_app/UI/Category/category_product.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/category/category.dart';

class BuildCategoryItem extends StatelessWidget {
  final Category category;

  const BuildCategoryItem({this.category});
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CategoryProduct.routeName, arguments: category.name);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.brown.withOpacity(0.7),
            elevation: 5,
            child: Center(
              child: Text(
                category.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppConfig.blockSizeVertical * 3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
