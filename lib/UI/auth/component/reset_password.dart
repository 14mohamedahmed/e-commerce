import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/provider/auth_provider.dart';

GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
final _emailcontroller = TextEditingController();
showResetPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'Reset Password',
        style: TextStyle(
          color: Colors.orange[900],
          fontSize: AppConfig.blockSizeVertical * 3,
        ),
      ),
      content: Form(
        key: _resetFormKey,
        child: TextFormField(
          controller: _emailcontroller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(
              fontSize: AppConfig.blockSizeVertical * 2.5,
            ),
          ),
          validator: (value) {
            if (value.isEmpty || !value.contains('@')) {
              return 'Invalid email!';
            }
            return null;
          },
          onSaved: (value) {
            _emailcontroller.text = value;
          },
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.orange[900],
          child: Text(
            'RESET',
            style: TextStyle(
                color: Colors.white,
                fontSize: AppConfig.blockSizeVertical * 2.5),
          ),
          onPressed: () {
            if (!_resetFormKey.currentState.validate()) {
              return;
            }
            Provider.of<AuthProvider>(context, listen: false)
                .resetPassword(_emailcontroller.text)
                .then((value) {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    ),
  );
}
