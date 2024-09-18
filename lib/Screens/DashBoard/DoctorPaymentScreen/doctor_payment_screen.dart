import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';

class DoctorPaymentScreen extends StatelessWidget {
  const DoctorPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          width: 100.w,
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
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(AppAssets.doctorImage)
                        )
                    ),
                  ),
                  SizedBox(width: 1.w,),
                  AppText(
                    text: "Alex",
                    fontSize: 14.sp, fontWeight: FontWeight.w600,
                    isTextCenter: false, textColor: textColor,
                    fontFamily: AppFonts.semiBold,),
                  const Spacer(),
                  AppText(
                    text: "June 9, 2024, 08:22 AM",
                    fontSize: 14.sp, fontWeight: FontWeight.w600,
                    isTextCenter: false, textColor: textColor,
                    fontFamily: AppFonts.semiBold,),
                  const Spacer(),
                  AppText(
                    text: "\$512",
                    fontSize: 14.sp, fontWeight: FontWeight.w600,
                    isTextCenter: false, textColor: textColor,
                    fontFamily: AppFonts.semiBold,),
                  const Spacer(),
                  SubmitButton(
                    width: 8.w,
                    height: 40,
                    title: "Completed",
                    press: () {

                    },),
                  SizedBox(width: 1.w,),
                  IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(CupertinoIcons.chevron_up,color: Colors.grey,)

                  )
                  // SvgPicture.asset(AppIcons.visibleIcon,height: 30,)
                ],
              ),
              const Divider(color: Colors.grey,),
              Row(
                children: [
                  
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20,),
    );
  }
}

class PayText extends StatelessWidget {
  const PayText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(text: "ID Payment", fontSize: 10.sp, fontWeight: FontWeight.w500, isTextCenter: isTextCenter, textColor: textColor)
      ],
    );
  }
}

