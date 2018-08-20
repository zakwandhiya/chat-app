import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BoxDecoration boxDecoration = BoxDecoration(
  gradient: new LinearGradient(
      colors: [Colors.blue[300], Colors.indigoAccent[100]],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 2.0),
      stops: [0.1, 0.9],
      tileMode: TileMode.clamp),
);

BoxDecoration boxDecorationForLoadingPage = BoxDecoration(
  gradient: 
  new LinearGradient(
      colors: [Colors.deepPurpleAccent[700], Colors.cyanAccent,],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 1.0),
      stops: [0.05, 0.95],
      tileMode: TileMode.clamp),
);

BoxDecoration boxDecorationForBottomNAvigation = BoxDecoration(
  gradient: 
  new LinearGradient(
      colors: [Color(0xff29c2fa), Colors.cyanAccent,],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 1.0),
      stops: [0.05, 0.95],
      tileMode: TileMode.clamp),
);
