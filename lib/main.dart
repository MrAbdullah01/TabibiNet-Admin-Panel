import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Provider/actionProvider/actionProvider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/dash_board_screen.dart';
import 'package:tabibinet_admin_panel/Screens/Start/SplashScreen/splash_screen.dart';

import 'Model/Res/Constants/app_colors.dart';
import 'Provider/Appointment/appointment_provider.dart';
import 'Provider/DashBoard/dash_board_provider.dart';
import 'Provider/DoctorPayment/doctor_payment_provider.dart';
import 'Provider/Faq/faq_provider.dart';
import 'Provider/HealthCare/health_care_provider.dart';
import 'Provider/Login/login_provider.dart';
import 'Provider/Patient/patient_provider.dart';
import 'Provider/Subscription/subscription_provider.dart';
import 'firebase_options.dart';

void main() async {

  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => LogInProvider(),),
              ChangeNotifierProvider(create: (context) => DashBoardProvider(),),
              ChangeNotifierProvider(create: (context) => HealthCareProvider(),),
              ChangeNotifierProvider(create: (context) => PatientProvider(),),
              ChangeNotifierProvider(create: (context) => AppointmentProvider(),),
              ChangeNotifierProvider(create: (context) => DoctorPaymentProvider(),),
              ChangeNotifierProvider(create: (context) => SubscriptionProvider(),),
              ChangeNotifierProvider(create: (context) => FaqProvider(),),
              ChangeNotifierProvider(create: (context) => ActionProvider(),),
            ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TabibiNet',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: themeColor,primary: themeColor),
              useMaterial3: true,
            ),
            home: DashBoardScreen(),
          ),
        );
    },);
  }
}

