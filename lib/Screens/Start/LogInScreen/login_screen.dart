import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:tabibinet_admin_panel/Model/Res/components/loadingButton.dart';
import 'package:tabibinet_admin_panel/Provider/Login/login_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/dash_board_screen.dart';

import '../../../Model/Res/utils/app_utils.dart';
import '../../../Provider/actionProvider/Authen_provider.dart';
import '../../../Provider/actionProvider/actionProvider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Form(
         key: _key,

        child: Row(
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
                    validator: (email){
                      if (emailC.text.isNotEmpty){
                        return AppUtils().validateEmail(email);

                      }
                      return 'Required';
                    },
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
                        validator: (password){
                          if (passwordC.text.isNotEmpty){
                            return AppUtils().passwordValidator(password);

                          }
                          return 'Required';
                        },
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
                  HoverLoadingButton(
                    width: 20.w,
                    height: 5.h,
                    text: "Log In",
                    onClicked: () async {
                      if(_key.currentState!.validate()){
                        _key.currentState!.save();
                        ActionProvider().setLoading(true);
                        Provider.of<AuthenticationProvider>(context,listen: false).signInUser(email: emailC.text.toString(),
                            password: passwordC.text.toString(), context: context);
                      }
                  },)
        
                ],
              ),
            ),
            const Spacer()
          ],
        ),
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
