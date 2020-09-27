import 'package:flutter/material.dart';
import 'package:shop_app/appConfig/app_config.dart';

class BuildAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    AppConfig().init(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
      ),
      child: Row(
        children: <Widget>[
          // build search Box
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    // leading search Icon
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.3),
                        size: 30,
                      ),
                    ),
                    //space
                    SizedBox(
                      width: width * 0.05,
                    ),
                    // title
                    Center(
                      child: Text(
                        'Shop App',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: AppConfig.blockSizeVertical * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //build app
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12.0),
            child: Container(
              child: Text(
                'Shop App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppConfig.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.add,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       showBottomSheet(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(45.0),
          //             topRight: Radius.circular(45.0),
          //           ),
          //         ),
          //         context: (context),
          //         builder: (context) => Container(
          //           height: height * 0.5,
          //           child: BuildBottomSheet(),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
