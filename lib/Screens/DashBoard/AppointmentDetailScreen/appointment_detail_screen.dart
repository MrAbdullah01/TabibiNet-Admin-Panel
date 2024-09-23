import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Provider/Appointment/appointment_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentDetailScreen/Component/appointment_detail_card.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../AppointmentScreen/Components/appointment_card.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentP = Provider.of<AppointmentProvider>(context,listen: false);
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            InkWell(
                onTap: () => appointmentP.setAppointmentScreen(false),
                child: SvgPicture.asset(AppIcons.undoIcon)),
            SizedBox(width: 1.w,),
            AppText2(
              text: "Appointment Details",
              fontSize: 16.sp, fontWeight: FontWeight.w600,
              isTextCenter: false, textColor: textColor,
              fontFamily: AppFonts.semiBold,),
          ],
        ),
        SizedBox(height: 2.h,),
        AppointmentDetailCard(),
        SizedBox(height: 2.h,),
        AppText2(
          text: "Recent Appointments",
          fontSize: 16.sp, fontWeight: FontWeight.w600,
          isTextCenter: false, textColor: textColor,
          fontFamily: AppFonts.semiBold,),
        SizedBox(height: 2.h,),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return AppointmentCard();
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10,),
        ),
      ],
    );
  }
}
