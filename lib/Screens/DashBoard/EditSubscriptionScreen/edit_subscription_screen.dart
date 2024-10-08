import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_drop_down_button.dart';
import 'package:tabibinet_admin_panel/Provider/Subscription/subscription_provider.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';

class EditSubscriptionScreen extends StatelessWidget {
  EditSubscriptionScreen({super.key});

  final List<String> sub = [
    "Basic",
    "Premium",
    "Advanced",
  ];

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
          text: "Change Subscription",
          fontSize: 14.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: themeColor,
          fontFamily: AppFonts.medium,),
        SizedBox(height: 2.h,),
        Consumer<SubscriptionProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                AppDropdown(
                  width: 25.w,
                  selectedValue: provider.selectSub,
                  items: sub,
                  hintText: "Select Subscription",
                  onChanged: (value) {
                    provider.setSubscription(value);
                  },),
              ],
            );
          },),
        SizedBox(height: 3.h,),
        Row(
          children: [
            SubmitButton(
              width: 15.w,
              title: "Change Subscription",
              press: () => null,
            ),
          ],
        ),


      ],
    );
  }
}
