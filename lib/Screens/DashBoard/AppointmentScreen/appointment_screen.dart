import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentScreen/Components/appointment_card.dart';

import 'Components/appointment_statusbar.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        AppointmentStatusBar(),
        SizedBox(height: 2.h,),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return AppointmentCard();
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20,),
        ),
      ],
    );
  }
}
