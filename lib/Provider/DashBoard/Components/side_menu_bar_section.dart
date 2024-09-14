import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../dash_board_provider.dart';

class SideMenuBarSection extends StatelessWidget {
  SideMenuBarSection({super.key});

  final List<Map<String ,String>> dashBoard = [
    {
      "title" : "Dashboard",
      "icon" : AppIcons.dashboardIcon
    },
    {
      "title" : "Health Care",
      "icon" : AppIcons.healthCareIcon
    },
    {
      "title" : "Patients",
      "icon" : AppIcons.patientIcon
    },
    {
      "title" : "Requests",
      "icon" : AppIcons.resultIcon
    },
    {
      "title" : "Appointments",
      "icon" : AppIcons.appointmentIcon
    },
    {
      "title" : "Appointment Fee",
      "icon" : AppIcons.appointmentFeeIcon
    },
    {
      "title" : "Doctor Payment",
      "icon" : AppIcons.doctorPaymentIcon
    },
    {
      "title" : "Patient Payment",
      "icon" : AppIcons.patientPaymentIcon
    },
    {
      "title" : "Subscription",
      "icon" : AppIcons.subscriptionIcon
    },
    {
      "title" : "Help Centre",
      "icon" : AppIcons.helpIcon
    },
    {
      "title" : "FAQS",
      "icon" : AppIcons.faqIcon
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (context, value, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: dashBoard.length,
            itemBuilder: (context, index) {
              final isSelected = value.selectIndex == index;
              return InkWell(
                onTap: () {
                  value.setSelectedIndex(index);
                },
                child: Container(
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                      color: isSelected? themeColor : bgColor
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.sp,),
                      SvgPicture.asset(
                        height: 20,
                        width: 20,
                        dashBoard[index]["icon"]!,
                        colorFilter: ColorFilter.mode(isSelected ? bgColor
                            : textColor, BlendMode.srcIn),
                      ),
                      SizedBox(width: 10.sp,),
                      AppTextWidget(
                          text: dashBoard[index]["title"]!,
                          fontSize: 12.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: isSelected ? bgColor : textColor,
                          fontFamily: AppFonts.semiBold),
                    ],
                  ),
                ),
              );
            },),
        );
      },);
  }
}
