import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/Components/patient_status_chart.dart';

import 'monthly_charts.dart';


class DashboardSection extends StatelessWidget {

  DashboardSection({super.key});

  // final List<Map<String, String>> items = [
  //   {
  //     "title" : "\$0",
  //     "subTitle" : "Earning",
  //     "icon" : AppIcons.dollarIcon,
  //   },
  //   {
  //     "title" : "\$0",
  //     "subTitle" : "Total Revenue",
  //     "icon" : AppIcons.revenueIcon,
  //   },
  //   {
  //     "title" : "36",
  //     "subTitle" : "Patients",
  //     "icon" : AppIcons.patient2Icon,
  //   },
  //   {
  //     "title" : "56",
  //     "subTitle" : "Doctors",
  //     "icon" : AppIcons.doctorIcon,
  //   },
  //   {
  //     "title" : "16",
  //     "subTitle" : "Appointment",
  //     "icon" : AppIcons.appointmentIcon,
  //   },
  //   {
  //     "title" : "8",
  //     "subTitle" : "Cancel\nAppointment",
  //     "icon" : AppIcons.cancelAppointmentIcon,
  //   },
  //   {
  //     "title" : "36",
  //     "subTitle" : "Doctor Request",
  //     "icon" : AppIcons.doctorRequestIcon,
  //   },
  //   {
  //     "title" : "56",
  //     "subTitle" : "Subscribers",
  //     "icon" : AppIcons.crownIcon,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {

    return Consumer<DashBoardProvider>(
      builder: (context, value, child) {
      final dashboardProvider = Provider.of<DashBoardProvider>(context, listen: false);

      // Initialize listeners when the widget is first built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        dashboardProvider.initializeListeners();
      });

      return Consumer<DashBoardProvider>(
        builder: (context, value, child) {
          final List<Map<String, dynamic>> items = [
            {
              "title": "\$0",
              "subTitle": "Earning",
              "icon": AppIcons.dollarIcon,
            },
            {
              "title": "\$0",
              "subTitle": "Total Revenue",
              "icon": AppIcons.revenueIcon,
            },
            {
              "title": "${value.patientCount}",
              "subTitle": "Patients",
              "icon": AppIcons.patient2Icon,
            },
            {
              "title": "${value.doctorCount}",
              "subTitle": "Doctors",
              "icon": AppIcons.doctorIcon,
            },
            {
              "title": "${value.appointmentCount}",
              "subTitle": "Appointment",
              "icon": AppIcons.appointmentIcon,
            },
            {
              "title": "${value.appointmentCancelCount}",
              "subTitle": "Cancel\nAppointment",
              "icon": AppIcons.cancelAppointmentIcon,
            },
            {
              "title": "0",
              "subTitle": "Doctor Request",
              "icon": AppIcons.doctorRequestIcon,
            },
            {
              "title": "0",
              "subTitle": "Subscriptions",
              "icon": AppIcons.crownIcon,
            },
          ];
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
                    mainAxisSpacing: 10,
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
            // PatientCountLineChart()
            FutureBuilder<Map<String, int>>(
              future: getUserCountByMonth(), // The future that resolves to user counts
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  // Pass the user count data to the BarChartSample1 widget
                  return BarChartSample1(userCounts: snapshot.data!);
                }
              },
            ),
          ],
        );
      },
      );
  });
}
  Future<Map<String, int>> getUserCountByMonth() async {
    Map<String, int> userCountByMonth = {};

    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('users').get();

    for (var doc in snapshot.docs) {
      Timestamp joinDateTimestamp = doc['creationDate'];
      DateTime joinDate = joinDateTimestamp.toDate();
      String formattedDate = DateFormat('MMMM yyyy').format(joinDate);

      if (userCountByMonth.containsKey(formattedDate)) {
        userCountByMonth[formattedDate] = userCountByMonth[formattedDate]! + 1;
      } else {
        userCountByMonth[formattedDate] = 1;
      }
    }

    return userCountByMonth;
  }
}
