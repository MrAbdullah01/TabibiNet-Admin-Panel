import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Screens/StartScreens/LogInScreen/login_screen.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    },);
    // _initialize();
    // FlutterLocalNotification.initialize(flutterLocalNotificationsPlugin);
  }

  // Future<void> _initialize() async {
  //   await Firebase.initializeApp();
  //   splashServices.isLogin();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.splashImage,height: 30.h,),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: 14,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
