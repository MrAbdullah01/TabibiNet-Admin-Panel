import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/firebase.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/toast_msg.dart';
import 'package:tabibinet_admin_panel/Provider/Login/login_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/dash_board_screen.dart';

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
                  color: themeColor.withOpacity(0.45),
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
                AppText(
                  text: "Email", fontSize: 14.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.medium,),
                SizedBox(height: 1.h,),
                AppTextField(
                  inputController: emailC,
                  hintText: "Enter Email",
                ),
                SizedBox(height: 3.h,),
                AppText(
                  text: "Password", fontSize: 14.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.medium,),
                SizedBox(height: 1.h,),
                Consumer<LogInProvider>(
                  builder: (context, value, child) {
                    return AppTextField(
                      inputController: passwordC,
                      hintText: "Enter Password",
                      obscureText: value.isVisible,
                      suffixIcon: IconButton(
                          onPressed: () {
                            value.setPasswordVisibility();
                            log("message:${value.isVisible}");
                          },
                          icon: Icon(
                            value.isVisible ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,)),
                    );
                },),
                SizedBox(height: 8.h,),
                SubmitButton(
                  title: "Log In",
                  press: () async {
                    // logIn();
                    Get.to(()=>DashBoardScreen());
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
      Get.to(()=> DashBoardScreen());
      ToastMsg().toastMsg("Log In Successfully!");
    },).onError((error, stackTrace) {
      ToastMsg().toastMsg(error.toString());
    },);
  }

}
