import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/Category/component/grid_item.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/product/product.dart';
import 'package:shop_app/provider/categories.dart';

class CategoryProduct extends StatelessWidget {
  static final String routeName = '/categoryProduct';
  @override
  Widget build(BuildContext context) {
    var categoryName = ModalRoute.of(context).settings.arguments as String;
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    final categoryProducts = Provider.of<Categories>(context);
    categoryProducts.fetchProductsByCategoryName(categoryName);
    AppConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          categoryName,
          style: TextStyle(
              color: Colors.black, fontSize: AppConfig.blockSizeVertical * 3),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: categoryProducts.fetchProductsByCategoryName(categoryName),
          builder: (context, snapshot) => snapshot.hasData
              ? snapshot.data.length > 0
                  ? buildCategoryProductBody(snapshot.data, categoryName)
                  : Center(
                      child: Text(
                        'There is no products yet!',
                        style: TextStyle(
                            fontSize: AppConfig.blockSizeVertical * 3),
                      ),
                    )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Widget buildCategoryProductBody(List<Product> product, String categoryName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 5,
        ),
        itemCount: product.length,
        itemBuilder: (context, index) => GridItem(
          product: product[index],
          categoryName: categoryName,
        ),
      ),
    );
  }
}
