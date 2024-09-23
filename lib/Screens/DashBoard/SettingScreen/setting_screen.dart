import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/firebase.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../Start/LogInScreen/login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashP = Provider.of<DashBoardProvider>(context,listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "Setting",
          fontSize: 16.sp, fontWeight: FontWeight.w600,
          isTextCenter: false, textColor: themeColor,
          fontFamily: AppFonts.semiBold,),
        SizedBox(height: 3.h,),
        SubmitButton2(
          width: 15.w,
          title: "Edit Profile",
          icon: AppIcons.editIcon,
          press: () {

          },),
        SizedBox(height: 2.h,),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.bellIcon,height: 20,),
                  SizedBox(width: 1.w,),
                  AppText(
                    text: "Notification",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: bgColor,
                    fontFamily: AppFonts.medium,),
                  SizedBox(width: 1.w,),
                  Consumer<DashBoardProvider>(
                    builder: (context, provider, child) {
                      return CupertinoSwitch(
                        value: provider.isNotification,
                        activeColor: bgColor,
                        thumbColor: themeColor,
                        trackColor: bgColor,
                        onChanged: (value) {
                          provider.setNotification(value);
                        },);
                    },)
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h,),
        SubmitButton2(
          width: 12.w,
          title: "Log Out",
          icon: AppIcons.logOutIcon,
          press: () {
            auth.signOut().whenComplete(() {
              Get.offAll(()=>LoginScreen());
            },);
          },)

      ],
    );
  }
}
