import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';
import '../shared widget/box_decoration.dart';
import './form_widget.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage(this.register);

  Function register;
  static String tag = 'register-page';
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DatabaseReference userRef;
  User user;

  Map<String, String> newUser = {
    'username': '',
    'email': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    userRef = database.reference().child('user');
  }

  handleRegister() {
    final FormState _form = formKey.currentState;

    if (_form.validate()) {
      _form.save();
      _form.reset();

      widget.register(
          newUser['email'], newUser['password'], newUser['username'], userRef);
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
        Navigator.pushNamed(context, '/login_page');
      }
    );

    return new Scaffold(
      bottomNavigationBar: bottomNavigation,
      body: SingleChildScrollView(child: 
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: boxDecorationForLoadingPage,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new SizedBox(height: 92.0),
                new Form(
                  key: formKey,
                  child: new ListView(
                    shrinkWrap: true,
                    padding: new EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                      loginWithFaceBookButton,
                      new SizedBox(height: 20.0),
                      formDivider,
                      new SizedBox(height: 40.0),
                      usernameInputField(newUser),
                      new SizedBox(height: 20.0),
                      emailInputField(newUser),
                      new SizedBox(height: 20.0),
                      passwordInputField(newUser),
                      new SizedBox(height: 30.0),
                      formButton(handleRegister , 'SIGN UP'),
                      // new SizedBox(height: 20.0),
                    ],
                  )
                ),
                new SizedBox(height: 50.0),
                Text('By signing up , you agree to our' , style: TextStyle(color: Colors.white.withOpacity(0.8) , fontSize: 18.0 ),),
                new SizedBox(height: 10.0),
                Text('Terms & Privacy Policy' , style: TextStyle(color: Colors.white.withOpacity(0.8) , fontSize: 18.0 , fontWeight: FontWeight.bold ))
              ],
            ),
          )
        )
      )
    );
  }
}
