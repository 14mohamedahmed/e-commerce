import 'package:flutter/material.dart';
import 'package:shop_app/appConfig/app_config.dart';

showErrorDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      elevation: 2.0,
      title: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        child: Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.white,
            size: AppConfig.blockSizeVertical * 10,
          ),
        ),
      ),
      titlePadding: EdgeInsets.all(0),
      content: Text(
        message,
        style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: AppConfig.blockSizeVertical * 2.5),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.orange[900],
          child: Text(
            'RETERY',
            style: TextStyle(
                color: Colors.white,
                fontSize: AppConfig.blockSizeVertical * 2.5),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
