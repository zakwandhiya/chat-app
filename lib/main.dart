// import 'package:flutter/material.dart';
// // import './pages/sandbox.dart';
// import 'package:flutter/rendering.dart';
// import './chat pages/chat_page.dart';
// import 'loading_page.dart';
// import './login page/register_page.dart';

// void main() {
// //  debugPaintSizeEnabled = true;
//   runApp(new MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'HA HA HA',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//         hintColor: Colors.white,
//         dividerColor: Colors.white
//       ),
//       // home: new ChatPage(title: 'Chat App v2'),
//       home: LoadingPage(),
//       // home: RegisterPage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_auth/firebase_auth.dart';

// import './pages/sandbox.dart';
import './chat pages/chat_page.dart';
import 'starting.dart';
import './login and register page/register_page.dart';
import './login and register page/login_page.dart';
import './model/user.dart';
import 'firebase_method.dart';



void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  FirebaseMethod firebaseMethod;
  FirebaseUser firebaseUser;
  User user;
  BuildContext ctx;

  initState(){
    super.initState();
    firebaseMethod = FirebaseMethod(updateFirebaseUser, updateUser);
  }

  updateFirebaseUser(FirebaseUser firebaseUser){
    this.firebaseUser = firebaseUser;
  }

  updateUser(User user){
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.white.withOpacity(0.8),
        dividerColor: Colors.white),
      // home: ChatPage(firebaseUser , user),
      home: StartingAppPage(updateFirebaseUser , updateUser ),
      // home:LoginPage(firebaseMethod) ,
      // home:RegisterPage(firebaseMethod.register) ,
      routes: {
        '/register_page': (BuildContext context) =>
            RegisterPage(firebaseMethod.register),
        '/login_page': (BuildContext context) =>
            LoginPage(firebaseMethod),
        '/chat_page': (BuildContext context) => ChatPage(firebaseUser,user),
      },
      // onGenerateRoute: (RouteSettings settings) {
      //   final List<String> pathElements = settings.name.split('/');
      //   if (pathElements[0] != '') {
      //     return null;
      //   }
      //   if (pathElements[1] == 'product') {
      //     final int index = int.parse(pathElements[2]);
      //     return MaterialPageRoute<bool>(
      //       builder: (BuildContext context) => ProductPage(
      //           _products[index]['title'], _products[index]['image']),
      //     );
      //   }
      //   return null;
      // },
      // onUnknownRoute: (RouteSettings settings) {
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) =>
      //           ProductsPage(_products, _addProduct, _deleteProduct));
      // },
    );
  }
}

