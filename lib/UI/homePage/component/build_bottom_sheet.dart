import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';

class BuildBottomSheet extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _imageFocus = FocusNode();
  var _titleText = TextEditingController();
  var _descriptionText = TextEditingController();
  var _priceText = TextEditingController();
  var _imageText = TextEditingController();
  var provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Products>(context, listen: false);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: _titleText,
                autofocus: true,
                textInputAction: TextInputAction.next,
                focusNode: _titleFocus,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  icon: Icon(
                    Icons.title,
                    size: 35,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                onSaved: (value) {
                  _titleText.text = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title mustn\'t be empty';
                  }
                  return null;
                },
                onEditingComplete: () {
                  _titleFocus.unfocus();
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: _descriptionText,
                autofocus: true,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  icon: Icon(
                    Icons.description,
                    size: 35,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                onSaved: (value) {
                  _descriptionText.text = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Description mustn\'t be empty';
                  }
                  return null;
                },
                onEditingComplete: () {
                  _descriptionFocus.unfocus();
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: _priceText,
                autofocus: true,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  icon: Icon(
                    Icons.attach_money,
                    size: 35,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                onSaved: (value) {
                  _priceText.text = value;
                },
                validator: (value) {
                  if (int.tryParse(value) == 0 || value.isEmpty) {
                    return 'Title mustn\'t be empty';
                  }
                  return null;
                },
                onEditingComplete: () {
                  _priceFocus.unfocus();
                  FocusScope.of(context).requestFocus(_imageFocus);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: _imageText,
                autofocus: true,
                textInputAction: TextInputAction.done,
                focusNode: _imageFocus,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: 'Image Url / Gallery',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  suffixIcon: Icon(Icons.camera),
                  icon: Icon(
                    Icons.image,
                    size: 35,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                onSaved: (value) {
                  _imageText.text = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'image mustn\'t be empty';
                  }
                  return null;
                },
                onEditingComplete: () {
                  _imageFocus.unfocus();
                },
              ),
            ),
            Container(
              child: FlatButton.icon(
                onPressed: () {
                  _submit();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.add),
                label: Text(
                  'ADD PRODUCT',
                  style: TextStyle(
                    color: Colors.brown.withOpacity(0.8),
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      provider.addProduct(_titleText.text, _descriptionText.text,
          double.tryParse(_priceText.text), _imageText.text);
      _priceText.text = '';
      _titleText.text = '';
      _descriptionText.text = '';
      _imageText.text = '';
    }
  }
}
