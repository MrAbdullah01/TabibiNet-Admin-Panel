import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';

class EditSubscriptionScreen extends StatelessWidget {
  const EditSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.profileImage),
            ),
            SizedBox(width: 1.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Alex",
                  fontSize: 16.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: textColor,
                  fontFamily: AppFonts.semiBold,),
                AppText(
                  text: "info@gmail.com",
                  fontSize: 14.sp, fontWeight: FontWeight.w500,
                  isTextCenter: false, textColor: Colors.grey,
                  fontFamily: AppFonts.medium,),
              ],
            ),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Patient subscription",
                  fontSize: 14.sp, fontWeight: FontWeight.w500,
                  isTextCenter: false, textColor: themeColor,
                  fontFamily: AppFonts.medium,),
                SizedBox(height: 1.h,),
                SubmitButton(
                  title: "Basic",
                  width: 10.w,
                  height: 40,
                  bgColor: Colors.grey,
                  bdColor: Colors.grey,
                  radius: 8,
                  press: () {

                  },),
              ],
            ),
          ],
        ),
        SizedBox(height: 5.h,),
        AppText(
          text: "Choose Subscription",
          fontSize: 14.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: themeColor,
          fontFamily: AppFonts.medium,),
        SizedBox(height: 1.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubmitButton(
              width: 10.w,
              title: "Basic",
              press: () => null,),
            SubmitButton(
              width: 10.w,
              title: "Premium",
              press: () => null,),
            SubmitButton(
              width: 10.w,
              title: "Advanced",
              press: () => null,),
            const SizedBox(),
            const SizedBox()
          ],
        ),
        SizedBox(height: 3.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const SizedBox(),
            SubmitButton(
              width: 15.w,
              title: "Change Subscription",
              press: () => null,
            ),
            const SizedBox(),
          ],
        )


      ],
    );
  }
}
