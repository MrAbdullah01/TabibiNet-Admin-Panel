import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController firstNameC = TextEditingController();
  final TextEditingController lastNameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController addressC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(AppAssets.profileImage),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: themeColor,
                      shape: BoxShape.circle
                  ),
                  child: SvgPicture.asset(AppIcons.cameraIcon),
                )
              ],
            ),
            SizedBox(width: 1.5.w,),
            SubmitButton(
              width: 10.w,
              height: 35,
              radius: 6,
              textSize: 12.sp,
              title: "Upload Photo",
              press: () {

            },)
          ],
        ),
        SizedBox(height: 2.h,),
        Row(
          children: [
            InfoField(text1: "First Name", controller: firstNameC),
            SizedBox(width: 10.w,),
            InfoField(text1: "Last Name", controller: lastNameC),
          ],
        ),
        SizedBox(height: 2.h,),
        Row(
          children: [
            InfoField(text1: "Email", controller: emailC),
            SizedBox(width: 10.w,),
            InfoField(text1: "Phone Number", controller: phoneC),
          ],
        ),
        SizedBox(height: 2.h,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InfoField(text1: "Address", controller: addressC),
            SizedBox(width: 10.w,),
            SubmitButton(
              width: 10.w,
              radius: 6,
              textSize: 14.sp,
              title: "Save",
              press: () {

              },),
          ],
        ),
      ],
    );
  }
}

class InfoField extends StatelessWidget {
  const InfoField({
    super.key,
    required this.text1,
    required this.controller,
  });

  final String text1;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: text1,
          fontSize: 12.sp, fontWeight: FontWeight.w600,
          isTextCenter: false, textColor: textColor,
          fontFamily: AppFonts.semiBold,),
        SizedBox(height: 1.h,),
        SizedBox(
            width: 15.w,
            child: AppTextField(
                inputController: controller,

            ))
      ],
    );
  }
}
