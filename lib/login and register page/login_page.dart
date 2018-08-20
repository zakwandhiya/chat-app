import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_database/firebase_database.dart';

import '../model/user.dart';
import '../shared widget/box_decoration.dart';
import './form_widget.dart';
import '../firebase_method.dart';
import 'dart:async';


class LoginPage extends StatefulWidget {
  LoginPage(this.firebaseMethod);

  FirebaseMethod firebaseMethod;
  static String tag = 'register-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();  

  DatabaseReference userRef;
  User user;

  Map<String ,String> newUser = {
    'email' : '',
    'password' : '',
  };

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    userRef = database.reference().child('user');
  }

  handleLogin() {
    print('============================');
    final FormState _form = formKey.currentState;

    if (_form.validate()) {
      _form.save();
      _form.reset();
      
      widget.firebaseMethod.login(newUser['email'] ,newUser['password'],  userRef).then((onValue){
        if(onValue){
          Navigator.pushNamed(context, '/chat_page');
        }
      });
    }
  }

  // void _updateUser(){
  //   MyApp.userSettings = new UserSettings(_username , defaultProfilePhoto);
  //   userRef.child(MyApp.firebaseUser.uid).push().set(_userSettings.toJson());
  // }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavigation = bottomNavigationBar(
      'Have an Account?',
      'Login',
      (){
        Navigator.pushNamed(context, '/register_page');
      }
    );


    return new Scaffold(
      bottomNavigationBar: bottomNavigation,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: boxDecorationForLoadingPage,
          child: ListView(
            children: <Widget>[
              new SizedBox(height: 100.0),
              logo,
              new Form(
                key: formKey,
                child: new ListView(
                  shrinkWrap: true,
                  padding: new EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    new SizedBox(height: 36.0),
                    emailInputField(newUser),
                    new SizedBox(height: 20.0),
                    passwordInputField(newUser),
                    new SizedBox(height: 30.0),
                    formButton(handleLogin , 'LOGIN'),
                    new SizedBox(height: 20.0),
                    formDivider,
                    loginWithFaceBookButton
                  ],
                )
              ),
            ],
          ),
        )
      )
    );
  }
}
