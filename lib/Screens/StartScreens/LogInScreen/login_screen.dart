import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/firebase.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/toast_msg.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                  height: 100.h,
                  width: 25.w,
                  child: Image.asset(AppAssets.logInImage,fit: BoxFit.cover,)),
              Container(
                height: 100.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.3),
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 35.w,
            height: 100.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: 30.h,
                      child: SvgPicture.asset(AppAssets.logoImage)),
                ),
                AppTextWidget(
                  text: "Email", fontSize: 14.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.medium,),
                AppTextField(inputController: emailC),
                SizedBox(height: 3.h,),
                AppTextWidget(
                  text: "Password", fontSize: 14.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.medium,),
                AppTextField(inputController: passwordC),
                SizedBox(height: 5.h,),
                SubmitButton(
                  title: "Log In",
                  press: () async {
                    await logIn();
                },)

              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
  Future<void> logIn() async {
    await auth.signInWithEmailAndPassword(
        email: emailC.text.toString(),
        password: passwordC.text.toString()
    ).then((value) {
      ToastMsg().toastMsg("Log In Successfully!");
    },).onError((error, stackTrace) {
      ToastMsg().toastMsg(error.toString());
    },);
  }
}
