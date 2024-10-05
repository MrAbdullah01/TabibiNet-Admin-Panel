import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';

class PatientPaymentScreen extends StatelessWidget {
  const PatientPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Patient Payment History",
                fontSize: 16.sp, fontWeight: FontWeight.w600,
                isTextCenter: false, textColor: themeColor,
                fontFamily: AppFonts.semiBold,
              ),
              const DefaultTabController(
                length: 3,
                child: SizedBox(
                  width: 280,
                  child: TabBar(
                      labelStyle: TextStyle(fontFamily: AppFonts.medium),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          text: "Monthly",
                        ),
                        Tab(
                          text: "Weekly",
                        ),
                        Tab(
                          text: "Today",
                        ),
                      ]),
                ),)
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
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
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage(AppAssets.doctorImage)
                              )
                          ),
                        ),
                        SizedBox(width: 1.w,),
                        AppText(
                          text: "Mrs John",
                          fontSize: 14.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: textColor,
                          fontFamily: AppFonts.semiBold,),
                        const Spacer(),
                        AppText(
                          text: "will show the date here",
                          fontSize: 14.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: textColor,
                          fontFamily: AppFonts.semiBold,),
                        const Spacer(),
                        Column(
                          children: [
                            AppText(
                              text: "Dr Alex",
                              fontSize: 14.sp, fontWeight: FontWeight.w600,
                              isTextCenter: false, textColor: textColor,
                              fontFamily: AppFonts.semiBold,),
                            AppText2(
                              text: "speciality",
                              fontSize: 11.sp, fontWeight: FontWeight.w600,
                              isTextCenter: false, textColor: themeColor,
                              fontFamily: AppFonts.medium,),
                          ],
                        ),
                        const Spacer(),
                        AppText(
                          text: "\$0",
                          fontSize: 14.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: textColor,
                          fontFamily: AppFonts.semiBold,),
                        const Spacer(),
                        SubmitButton(
                          width: 8.w,
                          height: 40,
                          bgColor: bgColor,
                          textColor: themeColor,
                          title: "Details",
                          press: () {

                          },),
                        // SvgPicture.asset(AppIcons.visibleIcon,height: 30,)
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20,),
          )
        ],
      ),
    );
  }
}
