import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import './model/user.dart';
import './shared widget/box_decoration.dart';
import './shared widget/loading_view.dart';



class StartingAppPage extends StatefulWidget {
  StartingAppPage(this.updateFirebaseUser , this.updateUser);
  
  Function updateFirebaseUser;
  Function updateUser;
  @override
  State createState() => new _StartingAppPageState();
}

class _StartingAppPageState extends State<StartingAppPage> {

  @override
  void initState() {
    super.initState();
    // FirebaseAuth.instance.signOut();
    print('============================== starting app');
    FirebaseAuth.instance.currentUser().then((FirebaseUser userFromFirebase){
      if(userFromFirebase != null){  
        // FirebaseAuth.instance.signOut();
        print('============================== is logged in');
        setState(() {
          widget.updateFirebaseUser(userFromFirebase);
        });   
        FirebaseDatabase.instance.reference().child('user').child(userFromFirebase.uid).once().then((onValue){
          print('============================== '+onValue.key);
          
          widget.updateUser(User.fromSnapshot(onValue));
          Navigator.pushReplacementNamed(context, '/chat_page');
        });
      }else{
        print('============================== to register page');
        Navigator
          .of(context)
          .pushNamed('/login_page')
          // .push(context , MaterialPageRoute(builder: (BuildContext context) => RegisterPage(firebaseMethod.register)))
          .catchError((e) => print(e));
      }
    });   
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LoadingView()
    );
  }
}