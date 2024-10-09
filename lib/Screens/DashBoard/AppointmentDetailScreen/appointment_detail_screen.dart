import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_drop_down_button.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/loadingButton.dart';
import 'package:tabibinet_admin_panel/Provider/Appointment/appointment_provider.dart';
import 'package:tabibinet_admin_panel/Provider/actionProvider/actionProvider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentDetailScreen/Component/appointment_detail_card.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentScreen/Components/model/appointmentModel.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Provider/DashBoard/dash_board_provider.dart';
import '../AppointmentScreen/Components/appointment_card.dart';

class AppointmentDetailScreen extends StatelessWidget {


   AppointmentDetailScreen({super.key});
  // final List<String> status = [
  //   "upcoming",
  //   "approve",
  //   "complete",
  //   "cancel",
  // ];
  @override
  Widget build(BuildContext context) {

    final appointment = Provider.of<AppointmentProvider>(context).selectedAppointment;
    final appointmentP = Provider.of<AppointmentProvider>(context,listen: false);
    final pro = Provider.of<DashBoardProvider>(context);

    // Convert timestamp to DateTime
    DateTime appointmentTime = DateTime.fromMillisecondsSinceEpoch(int.parse(appointment!.id));

    // Format the DateTime to mm/dd/yyyy
    String formattedTime = DateFormat('dd MMM,yyyy    hh:mm a').format(appointmentTime);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
    pro.setSelectedIndex(4);

    },
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
          Container(
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
                          borderRadius: BorderRadius.circular(80),
                          image:  DecorationImage(
                              image:
                              appointment.image != null && appointment.image.isNotEmpty
                                  ? NetworkImage(appointment.image) // If image URL is valid, load from network
                                  : AssetImage(AppAssets.doctorImage) as ImageProvider,
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    SizedBox(width: 1.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: appointment.patientName ,
                          fontSize: 14.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: textColor,
                          fontFamily: AppFonts.semiBold,),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.smsIcon,height: 17,),
                            const SizedBox(width: 10,),
                            AppText(
                                text: appointment.patientEmail,
                                fontSize: 12.sp, fontWeight: FontWeight.w500,
                                isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium)
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.phone2Icon,height: 15,),
                            const SizedBox(width: 10,),
                            AppText(
                                text: appointment.patientPhone,
                                fontSize: 12.sp, fontWeight: FontWeight.w500,
                                isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium)
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        AppText(
                            text: "Checkup Type",
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                        SizedBox(height: 1.h,),
                        AppText(
                            text: appointment.checkUpType,
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        AppText(
                            text: "Doctor Fee",
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                        SizedBox(height: 1.h,),
                        AppText(
                            text: "${appointment.doctorFee} MAD",
                            textDecoration: TextDecoration.underline,
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium,
                        )
                      ],
                    ),
                    SizedBox(width: 3.w,),
                  ],
                ),
                SizedBox(height: 1.h,),
                const Divider(color: textColor,),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Appointment Date and Time ",
                          fontSize: 12.sp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium,),
                        SizedBox(height: 1.h,),
                        AppText(
                            text: formattedTime,
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            text: "Location",
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                        SizedBox(height: 1.h,),
                        AppText(
                            text: appointment.doctorLocation,
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            text: "Doctor Name",
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                        SizedBox(height: 1.h,),
                        AppText(
                            text: appointment.doctorName,
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            text: "Visit Type",
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium),
                        SizedBox(height: 1.h,),
                        AppText(
                            text: appointment.checkUpType,
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: Colors.grey,fontFamily: AppFonts.medium
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          //AppointmentDetailCard(),
          SizedBox(height: 2.h,),
          // Container(
          //   width: 20.w,
          //   padding: const EdgeInsets.all(16.0),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          //   child: Consumer<AppointmentProvider>(
          //     builder: (context, appointmentP, child) {
          //       return DropdownButton<String>(
          //         value: appointmentP.selectedStatus.isEmpty ? null : appointmentP.selectedStatus,
          //         hint: Text(
          //           'Choose Status',
          //           style: TextStyle(
          //             color: Colors.grey[500],
          //             fontSize: 16,
          //           ),
          //         ),
          //         isExpanded: true,
          //         icon: const Icon(Icons.arrow_drop_down),
          //         items: status.map((String status) {
          //           return DropdownMenuItem<String>(
          //             value: status,
          //             child: Text(
          //               status,
          //               style: const TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           );
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           if (newValue != null) {
          //             log(newValue);
          //             // Update the status in the provider
          //             appointmentP.setStatusType(newValue);
          //           }
          //         },
          //       );
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: HoverLoadingButton(
          //       isIcon: false,
          //       text: 'Save', onClicked: () async{
          //    await _updateStatus(context);
          //   },width: 10.w, height: 5.h),
          // )
        ],
      ),
    );
  }

  Future<void> _updateStatus(context) async {
    ActionProvider.startLoading();
    var appointmentP = Provider.of<AppointmentProvider>(context,listen: false);
    final appointment = Provider.of<AppointmentProvider>(context,listen: false).selectedAppointment;
    // Update the appointment status in Firebase
    try {
      log("appointment id is:: ${appointment!.id}");
      await FirebaseFirestore.instance
          .collection('appointment')
          .doc(appointment.id) // Assuming 'id' is the document ID
          .update({
        'status': appointmentP.selectedStatus,
      });
      appointmentP.setStatusType(appointmentP.selectedStatus); // Optional, for immediate local sync.

      ActionProvider.stopLoading();
      // Show success message (if necessary)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment status updated!')),
      );
    } catch (e) {
      // Handle errors
      ActionProvider.stopLoading();
      log('Failed to update status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Failed to update status: $e')),
      );
    }
    }
}
