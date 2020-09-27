import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/homePage/component/build_product_item.dart';
import 'package:shop_app/provider/products.dart';

class BuildProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 5,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.getProducts.length,
        itemBuilder: (context, index) => BuildProductItem(
          product: products.getProducts[index],
          index: index,
        ),
      ),
    );
  }
}
