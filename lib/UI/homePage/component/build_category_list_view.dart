import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/homePage/component/build_category_item.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/model/category/category.dart';
import 'package:shop_app/provider/categories.dart';

class BuildCategoryListView extends StatefulWidget {
  @override
  _BuildCategoryListViewState createState() => _BuildCategoryListViewState();
}

class _BuildCategoryListViewState extends State<BuildCategoryListView> {
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    final categroy = Provider.of<Categories>(context);
    categroy.fetchCategories();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.1,
      width: width * 0.5,
      child: FutureBuilder(
        future: categroy.fetchCategories(),
        builder: (context, snapshot) => snapshot.hasData
            ? snapshot.data.length > 0
                ? buildListView(snapshot.data)
                : Text(
                    'Loading....',
                    style: TextStyle(fontSize: 18),
                  )
            : snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Text(
                      'No Category to Show!!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
      ),
    );
  }

  Widget buildListView(List<Category> category) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          return BuildCategoryItem(
            category: category[index],
          );
        });
  }
}
