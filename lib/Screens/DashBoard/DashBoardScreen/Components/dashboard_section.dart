import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/Components/patient_status_chart.dart';

class DashboardSection extends StatelessWidget {
  DashboardSection({super.key});

  final List<Map<String, String>> items = [
    {
      "title" : "\$450",
      "subTitle" : "Earning",
      "icon" : AppIcons.dollarIcon,
    },
    {
      "title" : "\$450",
      "subTitle" : "Total Revenue",
      "icon" : AppIcons.revenueIcon,
    },
    {
      "title" : "36",
      "subTitle" : "Patients",
      "icon" : AppIcons.patient2Icon,
    },
    {
      "title" : "56",
      "subTitle" : "Doctors",
      "icon" : AppIcons.doctorIcon,
    },
    {
      "title" : "16",
      "subTitle" : "Appointment",
      "icon" : AppIcons.appointmentIcon,
    },
    {
      "title" : "8",
      "subTitle" : "Cancel\nAppointment",
      "icon" : AppIcons.cancelAppointmentIcon,
    },
    {
      "title" : "36",
      "subTitle" : "Doctor Request",
      "icon" : AppIcons.doctorRequestIcon,
    },
    {
      "title" : "56",
      "subTitle" : "Subscribers",
      "icon" : AppIcons.crownIcon,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      children: [
        SizedBox(
          width: 80.w,
          child: GridView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                mainAxisExtent: 19.h,
                crossAxisSpacing: 20
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: items[index]["title"]!,
                            fontSize: 16.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,
                            fontFamily: AppFonts.semiBold,),
                          AppText(
                            text: items[index]["subTitle"]!,
                            fontSize: 12.sp, fontWeight: FontWeight.w400,
                            isTextCenter: false, textColor: textColor,
                            fontFamily: AppFonts.semiBold,maxLines: 2,),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: const BoxDecoration(
                          color: themeColor,
                          shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(
                          items[index]["icon"]!,
                          height: 20,
                          colorFilter: const ColorFilter.mode(bgColor, BlendMode.srcIn),
                        ),
                      )
                    ],
                  ),
                );
              },
          ),
        ),
        SizedBox(height: 15.sp,),
        const PatientStatusChart()
      ],
    );
  }
}
