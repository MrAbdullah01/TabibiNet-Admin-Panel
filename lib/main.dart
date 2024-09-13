import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Screens/StartScreens/SplashScreen/splash_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
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
      builder: (p0, p1, p2) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TabibiNet',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: themeColor,primary: themeColor),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
    },);
  }
}

