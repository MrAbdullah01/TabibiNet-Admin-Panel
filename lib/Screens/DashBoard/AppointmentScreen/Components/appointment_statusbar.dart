import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Widgets/submit_button.dart';
import '../../../../Provider/Appointment/appointment_provider.dart';

class AppointmentStatusBar extends StatelessWidget {
  AppointmentStatusBar({super.key});

  final List<String> status = [
    "Approval",
    "Upcoming",
    "Completed",
    "Cancel",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 100.w,
      child: Consumer<AppointmentProvider>(
        builder: (context, value, child) {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: status.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: 50,
                crossAxisSpacing: 100
            ),
            itemBuilder: (context, index) {
              final isSelected = value.selectStatus == index;
              return SubmitButton(
                title: status[index],
                bgColor: isSelected ? themeColor : bgColor,
                textColor: isSelected ? bgColor : themeColor,
                radius: 6,
                press: () {
                  value.setStatus(index);
                },);
            },
          );
        },),
    );
  }
}
