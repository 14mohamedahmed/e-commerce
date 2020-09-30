import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as h;
import 'package:shop_app/emvironment.dart';
import 'package:shop_app/model/user/user-images.dart';

class UserProvider extends ChangeNotifier {
  File _image;
  final _auth = FirebaseAuth.instance;
  final picker = ImagePicker();
  List<UserImage> _userImages;
  List<UserImage> get userImage => _userImages;
  Future<List<UserImage>> fetchUserImage() async {
    final User user = _auth.currentUser;
    final response =
        await h.get(Environment().url + 'userImages/${user.uid}.json');
    List<UserImage> userImage = [];
    final existingImages = json.decode(response.body) as Map<String, dynamic>;
    if (existingImages != null)
      existingImages.forEach((imageId, imageValue) {
        userImage.add(
          UserImage(
            id: imageId,
            photoUrl: imageValue['profile'],
          ),
        );
      });
    _userImages = userImage;
  }

  Future selectImage() async {
    final User user = _auth.currentUser;
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user image')
          .child(user.uid.toString())
          .child('profile.jpg');
      await ref.putFile(_image).onComplete;
      final _photoUrl = await ref.getDownloadURL();
      await h
          .post(
            Environment().url + '/userImages/${user.uid}.json',
            body: json.encode(
              {
                'profile': _photoUrl,
              },
            ),
          )
          .then((value) => print('done'));
    }
  }
}
