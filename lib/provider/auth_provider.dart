import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as h;

class AuthProvider extends ChangeNotifier {
  String getUserName;
  String _userName;
  String _userEmail;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FacebookLogin _fblogin = FacebookLogin();
  Future<dynamic> signUPWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      _catchError(error);
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      _catchError(error);
    }
  }

  Future<dynamic> signInWithFacebook() async {
    final FacebookLoginResult result = await _fblogin.logIn(['email']);
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        AuthCredential fbCredential =
            FacebookAuthProvider.getCredential(accessToken.token);
        FirebaseAuth.instance
            .signInWithCredential(fbCredential)
            .then((user) async {
          _userEmail = user.user.email;
          _userName = user.user.displayName;
          userInfo.setString('userName', _userName);
          userInfo.setString('userEmail', _userEmail);
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<dynamic> signInWithGoogle() async {
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(credential);
    User user = _auth.currentUser;
    _userEmail = user.email;
    _userName = user.displayName;
    userInfo.setString('userName', _userName);
    userInfo.setString('userEmail', _userEmail);
  }

  Future<dynamic> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      _catchError(error);
    }
  }

  Future<dynamic> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> saveUserInfo(String userName, String userEmail) async {
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    userInfo.setString('userName', userName);
    userInfo.setString('userEmail', userEmail);
  }

  Future<dynamic> getUserInfo() async {
    SharedPreferences getUser = await SharedPreferences.getInstance();
    getUserName = getUser.getString('userName');
  }

  Future<dynamic> clearUserInfo() async {
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    userInfo.remove('userEmail');
  }

  void _catchError(dynamic error) {
    var errorMessage = 'Authentication failed, try later!';
    if (error
        .toString()
        .contains('The email address is already in use by another account')) {
      errorMessage = 'This email address is already in use.';
    } else if (error.toString().contains(
        'There is no user record corresponding to this identifier. The user may have been deleted')) {
      errorMessage = 'This is not a valid email address';
    } else if (error.toString().contains('WEAK_PASSWORD')) {
      errorMessage = 'This password is too weak.';
    } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
      errorMessage = 'Could not find a user with that email';
    } else if (error.toString().contains(
        'The password is invalid or the user does not have a password')) {
      errorMessage = 'Invalid password.';
    }
    throw errorMessage;
  }
}
