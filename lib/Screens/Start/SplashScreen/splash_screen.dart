import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Services/SplashServices/splash_services.dart';
import '../LogInScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
    // _initialize();
    // FlutterLocalNotification.initialize(flutterLocalNotificationsPlugin);
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Center(child: SvgPicture.asset(AppAssets.splashImage,height: 60.h,)),
      ),
    );
  }
}
