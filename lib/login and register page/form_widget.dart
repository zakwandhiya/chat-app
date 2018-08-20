import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../model/user.dart';
import '../shared widget/box_decoration.dart';
import 'package:flutter_svg/flutter_svg.dart';

final logo = new Hero(
  tag: 'hero',
  child: new Container(
    height: 200.0,
    width: 200.0,
    child: SvgPicture.asset(
      'assets/chat_app_white_icon.svg',
      color: Colors.white,
      matchTextDirection: true,
    ),
  ),
);

Widget usernameInputField(Map<String ,String> newUser) => new TextFormField(
  onSaved: (val) => newUser['username'] = val,
  validator: (val) => val == "" ? val : null,
  keyboardType: TextInputType.emailAddress,
  autofocus: false,
  style: TextStyle(color: Colors.white.withOpacity(0.8)),
  decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 24.0 , vertical: 12.0),
    border: InputBorder.none,
    fillColor: Colors.white.withOpacity(0.1),
    filled: true,
    labelText: 'Username',
  ),
);

Widget emailInputField(Map<String ,String> newUser) =>TextFormField(
  onSaved: (val) => newUser['email'] = val,
  validator: (val) => val == "" ? val : null,
  keyboardType: TextInputType.emailAddress,
  autofocus: false,
  style: TextStyle(color: Colors.white.withOpacity(0.8)),
  decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 24.0 , vertical: 12.0),
    border: InputBorder.none,
    fillColor: Colors.white.withOpacity(0.1),
    filled: true,
    labelText: 'Email',
  ),
);

Widget passwordInputField(Map<String ,String> newUser) => TextFormField(
  onSaved: (val) =>newUser['password'] = val,
  validator: (val) => val == "" ? val : null,
  autofocus: false,
  obscureText: true,
  style: TextStyle(color: Colors.white.withOpacity(0.8)),
  decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 24.0 , vertical: 12.0),
    border: InputBorder.none,
    fillColor: Colors.white.withOpacity(0.1),
    filled: true,
    labelText: 'Password',
  ),
);

formButton(pressed , String tittle) => Container(
  padding: EdgeInsets.symmetric(vertical: 8.0),
  child: OutlineButton(
    
    padding: EdgeInsets.symmetric(vertical: 24.0),
    child: Text(tittle , style: TextStyle(color: Colors.white.withOpacity(0.6)),),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
    onPressed: () {
      print('object');
      pressed();
    },
  ),
);

final loginWithFaceBookButton = Container(
  child: Container(
    // color: Color(0xff0099ff),
    padding: EdgeInsets.symmetric(vertical: 24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 16.0),
          height: 28.0,
          width: 28.0,
          child: SvgPicture.asset(
            'assets/facebook-app-logo.svg',
            color: Colors.white,
            matchTextDirection: true,
          ),
        ),
        Text('LOGIN WITH FACEBOOK' ,
          style : TextStyle(color: Colors.white , fontSize: 16.0 ,fontWeight: FontWeight.bold)
        )
      ],
    ),
    // onPressed: () {
    //   print('pressed');
    // },
  ),
);

final formDivider = Container(
  padding: EdgeInsets.symmetric(horizontal: 24.0),
  child: Row(
    children: <Widget>[
      Expanded(
        flex: 3,
        child: Divider(),
      ),
      Expanded(
        child: Center(
            child: Text(
          'OR',
          style: TextStyle(color: Colors.white),
        )),
      ),
      Expanded(
        flex: 3,
        child: Divider(),
      ),
    ],
  )
);

final forgotLabel = new FlatButton(
  child: new Text(
    'Forgot password?',
    style: new TextStyle(color: Colors.black54),
  ),
  onPressed: () {},
);

Widget bottomNavigationBar(String stringForText ,String stringForButton , Function callback) => Container(
  padding: EdgeInsets.all(0.0),
  
  height: 70.0,
  decoration: boxDecorationForBottomNAvigation,
  child: Column(
    children: <Widget>[
      Divider(
        height: 0.0,
      ),
      Container(
        padding: EdgeInsets.only(top: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(stringForText , style: TextStyle(color: Colors.white , fontSize: 17.0),),
            FlatButton(
            child: Text(stringForButton, style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 17.0)),
            onPressed: (){
              callback();
            },
            )
            // button
          ],
        ),
      )
    ],
  ),
);
    