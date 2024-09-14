import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/header.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/Components/side_menu_bar_section.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/Components/dashboard_section.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HealthCareScren/health_care_screen.dart';

import '../../../Model/Res/Constants/app_assets.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      body: Column(
        children: [
          const Header(),
          Row(
            children: [
              Container(
                height: 72.h,
                width: 20.w,
                margin: EdgeInsets.all(16.sp),
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.profileImage),
                    ),
                    AppTextWidget(
                        text: "Mian Uzair",
                        fontSize: 14.sp, fontWeight: FontWeight.w600,
                        isTextCenter: false, textColor: themeColor,
                        fontFamily:  AppFonts.semiBold),
                    const Divider(
                      color: themeColor,
                      indent: 10,
                      endIndent: 10,
                    ),
                    SideMenuBarSection(),
                    SizedBox(height: 10.sp,),
                    SubmitButton2(
                      width: 18.w,
                      height: 40,
                      title: "Logout",
                      icon: AppIcons.logOutIcon,
                      press: () {

                      },)
                  ],
                ),
              ),
              Consumer<DashBoardProvider>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 72.h,
                      width: 75.w,
                      child: value.selectIndex == 0 ? DashboardSection()
                          :value.selectIndex == 1 ? HealthCareScreen()
                          : const SizedBox()
                  );
                },),
            ],
          )
        ],
      ),
    );
  }
}
