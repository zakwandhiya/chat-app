import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';
import './box_decoration.dart';



class LoadingView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final logo = new Hero(
      tag : 'hero',
      child: new Container(
        height: 300.0,
        width: 300.0,
        child: SvgPicture.asset('assets/chat_app_white_icon.svg',
            color: Colors.white,
            matchTextDirection: true,),
      ),
    );

    return Container(
        decoration: boxDecorationForLoadingPage,
        child: Center(
          child: logo,
        ),
    );
  }
}