import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import './model/user.dart';

String defaultProfilePhoto =
    "https://firebasestorage.googleapis.com/v0/b/chat-app4.appspot.com/o/profile_photo%2Ftzuyu.PNG?alt=media&token=f01af3b6-0e79-44a1-b2f2-d1874e16cd45";

class FirebaseMethod {
  FirebaseMethod(this.updateFirebaseUser, this.updateUser);

  FirebaseAuth auth = FirebaseAuth.instance;
  Function updateFirebaseUser;
  Function updateUser;

  register(String email, password, username, DatabaseReference userRef) {
    
    auth.createUserWithEmailAndPassword(email: email, password: password).then((onValue) {
      updateFirebaseUser(onValue);
      User tmp = User(username, defaultProfilePhoto, onValue.uid);

      userRef.child(tmp.user_id).set(tmp.toJson()).then((onValue) {
        updateUser(tmp);
      }).catchError((onError){
        
      });
    }).catchError((onError){

    });
  }

  login(String email, password, DatabaseReference userRef) {

    bool status = false;

    auth.signOut();
    return auth.signInWithEmailAndPassword(email: email,password: password).then((onValue) {
        updateFirebaseUser(onValue);
        printf('sign in');
         return userRef.child(onValue.uid).once().then((onValue){
          
          printf('get user');
          updateUser(User.fromSnapshot(onValue));

          status = true;
          return status;
        }).catchError((onError){
          printf('failed to get user');   
        });

    }).catchError((onError){
      printf('failed to log in');
    });

  }

// Future<bool> login(String email, password, DatabaseReference userRef) async{

//     bool status = false;

//     auth.signOut();
//     await auth.signInWithEmailAndPassword(email: email,password: password).then((onValue) async{

//         firebaseUser = onValue;
//         printf('sign in');
//         await userRef.child(firebaseUser.uid).once().then((onValue){
          
//           printf('get user');
//           user = User.fromSnapshot(onValue);
//           print(user.profile_photo);

//           status = true;
//         }).catchError((onError){
//           printf('failed to get user');   
//         });

//     }).catchError((onError){
//       printf('failed to log in');
//     });

//     return status;
//   }


  printf(String string){
    print('==================================================='+string);
  }
}
