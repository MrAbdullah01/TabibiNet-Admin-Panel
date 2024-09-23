import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "View Profile",
          fontSize: 16.sp, fontWeight: FontWeight.w600,
          isTextCenter: false, textColor: themeColor,
          fontFamily: AppFonts.semiBold,),
        SizedBox(height: 3.h,),
        Container(
          padding: const EdgeInsets.all(20),
          width: 100.w,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(AppAssets.profileImage),
              ),
              SizedBox(width: 1.w,),
              AppText(
                text: "Mian Uzair",
                fontSize: 16.sp, fontWeight: FontWeight.w600,
                isTextCenter: false, textColor: themeColor,
                fontFamily: AppFonts.semiBold,
              ),
              const Spacer(),
              const SizedBox(
                  height: 120,
                  child: VerticalDivider(color: themeColor,)),
              SizedBox(width: 1.w,),
              SizedBox(
                width: 20.w,
                child: Column(
                  children: [
                    const RowText(text1: "Phone:", text2: "(+212) 06 11 45 56 67"),
                    SizedBox(height: 1.h,),
                    const RowText(text1: "Email:", text2: "Info@gmail.com"),
                    SizedBox(height: 1.h,),
                    const RowText(text1: "Address:", text2: "Home 1234"),
                    SizedBox(height: 1.h,),
                    const RowText(text1: "Gender:", text2: "Male"),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText2(
            text: text1,
            fontSize: 12.sp, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium
        ),
        AppText2(
            text: text2,
            fontSize: 12.sp, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: themeColor,fontFamily: AppFonts.medium,
        ),
      ],
    );
  }
}

