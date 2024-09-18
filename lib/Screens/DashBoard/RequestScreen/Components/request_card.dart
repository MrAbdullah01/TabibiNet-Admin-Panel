import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_icons.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../../Model/Res/Widgets/submit_button.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.doctorName,
    required this.doctorSpeciality,
    required this.doctorImage,
  });

  final String doctorName;
  final String doctorSpeciality;
  final String doctorImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppIcons.crossIcon,height: 15,),
          ),
          CircleAvatar(
            radius: 5.h,
            backgroundImage: AssetImage(doctorImage),
          ),
          const Spacer(),
          AppText(
            text: doctorName,
            fontSize: 14.sp, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: textColor,
            fontFamily: AppFonts.semiBold,),
          AppText(
            text: doctorSpeciality,
            fontSize: 10.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: themeColor,
          ),
          SizedBox(height: 3.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SubmitButton(
                title: "Decline",
                width: 6.w,
                height: 25,
                textSize: 10.sp,
                bgColor: bgColor,
                textColor: themeColor,
                press: () {

                },),
              SubmitButton(
                title: "Accept",
                width: 6.w,
                height: 25,
                textSize: 10.sp,
                press: () {

                },),
            ],
          ),
          const Spacer(),

        ],
      ),
    );
  }
}
