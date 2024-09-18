import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Widgets/submit_button.dart';
import '../../../../Provider/Appointment/appointment_provider.dart';

class AppointmentStatusBar extends StatelessWidget {
  AppointmentStatusBar({super.key});

  final List<String> status = [
    "Requesting",
    "Cancel",
    "Completed",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100.w,
      child: Consumer<AppointmentProvider>(
        builder: (context, value, child) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: status.length,
            itemBuilder: (context, index) {
              final isSelected = value.selectStatus == index;
              return SubmitButton(
                title: status[index],
                bgColor: isSelected ? themeColor : bgColor,
                textColor: isSelected ? bgColor : themeColor,
                width: 10.w,
                press: () {
                  value.setStatus(index);
                },);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 20,),
          );
        },),
    );
  }
}
