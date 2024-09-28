import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/dash_board_screen.dart';

import '../../Model/Res/Widgets/toast_msg.dart';
import '../../Model/Res/utils/app_utils.dart';
import 'actionProvider.dart';

class AuthenticationProvider extends ChangeNotifier{
  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final login = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (login.user != null) {
        ActionProvider.stopLoading();
        ToastMsg().toastMsg("Login successful.");
        //AppUtils().showToast(text: "Login Successful");
        Get.to(DashBoardScreen());

        log("Login successful");
      }
    } on FirebaseAuthException catch (e) {
      ActionProvider.stopLoading();
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        ToastMsg().toastMsg("Login failed, No user found for that email.");

      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        ToastMsg().toastMsg("Wrong password provided for that user.");
        // AppUtils().showToast(text: "Wrong password provided.",);
        //AppUtils().showToast(text:  "Login failed Wrong password provided.",);

      } else {
       // AppUtils().showToast(text:"Login failed: ${e.message}",);

        log('Login failed: ${e.message}');
        ToastMsg().toastMsg("Login failed: ${e.message}");

      }
    }
  }

}