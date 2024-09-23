import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Provider/Appointment/appointment_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentDetailScreen/appointment_detail_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentScreen/Components/appointment_card.dart';

import 'Components/appointment_statusbar.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
      builder: (context, value, child) {
        return value.isAppointmentDetail ?
        AppointmentDetailScreen() :
        ListView(
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
      },);
  }
}
