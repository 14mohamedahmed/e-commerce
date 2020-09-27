import 'package:flutter/material.dart';
import 'package:shop_app/appConfig/app_config.dart';

class BuildSettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  BuildSettingCard({@required this.icon, @required this.title});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    AppConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.orange[900],
                  size: AppConfig.blockSizeVertical * 4,
                ),
                SizedBox(width: width * 0.03),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppConfig.blockSizeVertical * 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 60),
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
