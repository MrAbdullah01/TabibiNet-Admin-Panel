import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/firebase.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AddFaqScreen/add_faq_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentDetailScreen/appointment_detail_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DoctorPaymentScreen/doctor_payment_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/FaqScreen/faq_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HelpCenterScreen/help_center_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/PatientPaymentScreen/patient_payment_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/ProfileScreen/profile_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/SettingScreen/setting_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/SubscriptionScreen/subscription_screen.dart';
import 'package:tabibinet_admin_panel/Screens/Start/LogInScreen/login_screen.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/header.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/DashBoard/Components/side_menu_bar_section.dart';
import '../../../Provider/DashBoard/dash_board_provider.dart';
import '../../../Provider/profileProvider/profileInfo.dart';
import '../AppointmentFeeScreen/appointment_fee_screen.dart';
import '../AppointmentScreen/appointment_screen.dart';
import '../DoctorSpeciality/doctorSpecialityScreen.dart';
import '../EditProfileScreen/edit_profile_screen.dart';
import '../HealthCareScren/health_care_screen.dart';
import '../PatientScreen/patient_screen.dart';
import '../RequestScreen/request_screen.dart';
import 'Components/dashboard_section.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashInfoo = Provider.of<ProfileInfoProvider>(context);
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
                child: Consumer<ProfileInfoProvider>(
                  builder: (context, dashInfo, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.h,),
                        CircleAvatar(
                          backgroundImage:
                          dashInfo.profileImageUrl != null
                              ? NetworkImage(dashInfo.profileImageUrl!)
                              : AssetImage(AppAssets.profileImage),
                        ),
                        SizedBox(height: 1.h,),
                        AppText(
                            text:   dashInfo.profileName != null
                                ? dashInfo.profileName.toString()   +" "+ dashInfo.profileLastName.toString(): "Loading...",
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
                            auth.signOut().whenComplete(() {
                              Get.offAll(()=>LoginScreen());
                            },);
                          },)
                      ],
                    );
                  },
                ),
              ),
              Consumer<DashBoardProvider>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: 72.h,
                      width: 75.w,
                      child
                          :value.selectIndex == 0 ? DashboardSection()
                          :value.selectIndex == 1 ? HealthCareScreen()
                          :value.selectIndex == 2 ? PatientScreen()
                          // :value.selectIndex == 3 ? RequestScreen()
                          :value.selectIndex == 3 ? AppointmentScreen()
                          :value.selectIndex == 4 ? AppointmentFeeScreen()
                          :value.selectIndex == 5 ? const DoctorPaymentScreen()
                          :value.selectIndex == 6 ? const PatientPaymentScreen()
                          :value.selectIndex == 7 ? SubscriptionScreen()
                          :value.selectIndex == 8 ? HelpCenterScreen()
                          :value.selectIndex == 9 ? const FaqScreen()
                          :value.selectIndex == 10 ? DoctorSpecialityScreen()
                          :value.selectIndex == 11 ? const ProfileScreen()
                          :value.selectIndex == 12 ? EditProfileScreen()
                          :value.selectIndex == 13 ? const SettingScreen()
                          :value.selectIndex == 14 ?  AddFaqScreen()
                          :value.selectIndex == 15 ?  AppointmentDetailScreen()
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
