import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Screens/DashBoard/DashBoardScreen/dash_board_screen.dart';
import '../../../Screens/Start/LogInScreen/login_screen.dart';

class SplashServices {

  Future<void> isLogin(context) async {

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen(),));
      },);
    }
    else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      },);
    }
  }

}