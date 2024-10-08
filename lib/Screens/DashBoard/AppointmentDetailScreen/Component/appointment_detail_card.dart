import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Res/Constants/app_assets.dart';
import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_icons.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';

class AppointmentDetailCard extends StatelessWidget {
  const AppointmentDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage(AppAssets.doctorImage)
                    )
                ),
              ),
              SizedBox(width: 1.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Alex",
                    fontSize: 14.sp, fontWeight: FontWeight.w600,
                    isTextCenter: false, textColor: textColor,
                    fontFamily: AppFonts.semiBold,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.smsIcon,height: 17,),
                      const SizedBox(width: 10,),
                      AppText(
                          text: "info@gmail.com",
                          fontSize: 12.sp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium)
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.phone2Icon,height: 15,),
                      const SizedBox(width: 10,),
                      AppText(
                          text: "+212 124-567-890-1",
                          fontSize: 12.sp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium)
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  AppText(
                      text: "Checkup Type",
                      fontSize: 12.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                  SizedBox(height: 1.h,),
                  AppText(
                    text: "Cardiology",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                  )
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  AppText(
                      text: "Doctor Fee",
                      fontSize: 12.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                  SizedBox(height: 1.h,),
                  AppText(
                    text: "\$220",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                  )
                ],
              ),
              SizedBox(width: 3.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          const Divider(color: textColor,),
          SizedBox(height: 1.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: "Appointment Date and Time ",
                      fontSize: 12.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium,),
                  SizedBox(height: 1.h,),
                  AppText(
                    text: "11 Sep, 2024   10:45Am",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: "Location",
                      fontSize: 12.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                  SizedBox(height: 1.h,),
                  AppText(
                    text: "New York",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: "Doctor Name",
                      fontSize: 12.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                  SizedBox(height: 1.h,),
                  AppText(
                    text: "Dr. John",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: "Visit Type",
                      fontSize: 12.sp, fontWeight: FontWeight.w500,
                      isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                  SizedBox(height: 1.h,),
                  AppText(
                    text: "General",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
