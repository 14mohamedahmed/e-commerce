import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/UI/auth/component/error_dialog.dart';
import 'package:shop_app/UI/auth/component/reset_password.dart';
import 'package:shop_app/appConfig/app_config.dart';
import 'package:shop_app/bottom_navy_bar.dart';
import 'package:shop_app/provider/auth_provider.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isSignUp = false;
  bool showingSpinner = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: ModalProgressHUD(
          inAsyncCall: showingSpinner,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange[900],
                  Colors.orange[800],
                  Colors.orange[400],
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          isSignUp ? 'Signup' : 'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.blockSizeVertical * 4),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          isSignUp ? 'Lets Sign Up' : 'Welcome back',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppConfig.blockSizeVertical * 3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Container(
                    width: width,
                    height: height * 0.712,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              color: Colors.white,
                              elevation: 10,
                              shadowColor: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  children: <Widget>[
                                    if (isSignUp)
                                      Container(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter Name',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[200]),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return '\* Enter Your Name';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _nameController.text = value;
                                          },
                                          controller: _nameController,
                                        ),
                                      ),
                                    Container(
                                      child: TextFormField(
                                        controller: _emailController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return '\* Enter Your email';
                                          } else if (!value.contains('@')) {
                                            return '\* Email is incorrect';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _emailController.text = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Enter Email',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[200]))),
                                      ),
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return '\* Enter your password';
                                          } else if (value.length < 6) {
                                            return '\* password Should be at least 6 Charcters';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _passwordController.text = value;
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: 'Enter Password',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[200]))),
                                      ),
                                    ),
                                    if (isSignUp)
                                      Container(
                                        child: TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return '\* enter your confirmed password';
                                            } else if (value !=
                                                _passwordController.text) {
                                              return '\* didn\'t match password';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _confirmPasswordController.text =
                                                value;
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: 'Confirm Password',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            if (!isSignUp)
                              GestureDetector(
                                onTap: () {
                                  showResetPasswordDialog(context);
                                },
                                child: Container(
                                  child: Text('Forget Password?',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize:
                                              AppConfig.blockSizeVertical *
                                                  2.5)),
                                ),
                              ),
                            if (!isSignUp) SizedBox(height: height * 0.03),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    showingSpinner = true;
                                  });
                                  if (isSignUp) {
                                    provider
                                        .signUPWithEmailAndPassword(
                                            _nameController.text,
                                            _emailController.text,
                                            _passwordController.text)
                                        .then((value) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              BuildBottomNavyBar.routeName);
                                    }).catchError((error, test) {
                                      showErrorDialog(error, context);
                                    }).then((value) {
                                      setState(() {
                                        showingSpinner = false;
                                      });
                                    });
                                    provider.saveUserInfo(_nameController.text,
                                        _emailController.text);
                                  } else {
                                    provider
                                        .signInWithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text)
                                        .then((value) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              BuildBottomNavyBar.routeName);
                                    }).catchError((error, test) {
                                      showErrorDialog(error, context);
                                    }).then((value) {
                                      setState(() {
                                        showingSpinner = false;
                                      });
                                    });
                                  }
                                } else {
                                  print('error while sign in');
                                }
                              },
                              child: Container(
                                height: height * 0.06,
                                width: width,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        AppConfig.blockSizeHorizontal * 15),
                                decoration: BoxDecoration(
                                  color: Colors.orange[900],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  isSignUp ? 'Signup' : 'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          AppConfig.blockSizeVertical * 3),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    !isSignUp
                                        ? 'don\'t have an account? '
                                        : 'Already have an account? ',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize:
                                            AppConfig.blockSizeVertical * 2.5),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignUp = !isSignUp;
                                    });
                                  },
                                  child: Container(
                                    child: Text(isSignUp ? 'Login' : 'Signup',
                                        style: TextStyle(
                                            color: Colors.blue[600],
                                            fontSize:
                                                AppConfig.blockSizeVertical *
                                                    2.5)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                            if (!isSignUp)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      provider
                                          .signInWithFacebook()
                                          .then((value) {
                                        setState(() {
                                          showingSpinner = true;
                                        });
                                        if (provider.fbResult ==
                                            FacebookLoginStatus.loggedIn) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                            BuildBottomNavyBar.routeName,
                                          );
                                        }
                                      }).whenComplete(() {
                                        setState(() {
                                          showingSpinner = false;
                                        });
                                      });
                                    },
                                    child: Image.asset('assets/facebook.png',
                                        fit: BoxFit.fill),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      provider.signInWithGoogle().then((value) {
                                        setState(() {
                                          showingSpinner = true;
                                        });
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          BuildBottomNavyBar.routeName,
                                        );
                                      });
                                      setState(() {
                                        showingSpinner = false;
                                      });
                                    },
                                    child: Image.asset('assets/google.png',
                                        fit: BoxFit.cover),
                                  ),
                                  Image.asset('assets/twitter.png',
                                      fit: BoxFit.cover),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
