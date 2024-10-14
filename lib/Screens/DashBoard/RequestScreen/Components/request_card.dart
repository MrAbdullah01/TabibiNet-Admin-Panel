import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/toast_msg.dart';

import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_icons.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../../Model/Res/Widgets/submit_button.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.doctorName,
    required this.doctorSpeciality,
    required this.doctorImage,
    required this.doctorId,
    required this.withdrawId,
    required this.withdrawAmount,
  });

  final String doctorName;
  final String doctorSpeciality;
  final String doctorImage;
  final String doctorId;
  final String withdrawId;
  final String withdrawAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppIcons.crossIcon,height: 15,),
          ),
          CircleAvatar(
            radius: 5.h,
            backgroundImage: NetworkImage(doctorImage),
          ),
          const Spacer(),
          AppText(
            text: doctorName,
            fontSize: 14.sp, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: textColor,
            fontFamily: AppFonts.semiBold,),
          AppText(
            text: doctorSpeciality,
            fontSize: 10.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: themeColor,
          ),
          SizedBox(height: 1.h,),
          AppText(
            text: "Withdraw Amount: $withdrawAmount",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: themeColor,),
          SizedBox(height: 3.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SubmitButton(
                title: "Decline",
                width: 6.w,
                height: 25,
                textSize: 10.sp,
                bgColor: bgColor,
                textColor: themeColor,
                press: () {
                  updateDoctorStatus(doctorId, withdrawId,'rejected',withdrawAmount);
                },),
              SubmitButton(
                title: "Accept",
                width: 6.w,
                height: 25,
                textSize: 10.sp,
                press: () {
                  updateDoctorStatus(doctorId, withdrawId,'approved',withdrawAmount);
                },),
            ],
          ),
          const Spacer(),

        ],
      ),
    );
  }
  // Method to update the doctor status in Firebase
  // Future<void> updateDoctorStatus(String doctorId, String newStatus) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('withdrawRequests')  // Make sure this is the correct collection
  //         .doc(doctorId)        // Reference the correct doctor by ID
  //         .update({'status': newStatus});// Update accountStatus field
  //     ToastMsg().toastMsg("You $newStatus this user");
  //   } catch (e) {
  //     log('Error updating doctor status: $e');
  //   }
  // }
  Future<void> updateDoctorStatus(String doctorId,String withdrawId, String newStatus, String withdrawAmount) async {
    try {
      // Update withdraw request status
      await FirebaseFirestore.instance
          .collection('withdrawRequests')
          .doc(withdrawId)
          .update({'status': newStatus});

      if (newStatus == 'rejected') {
        // Fetch the user document to confirm it exists
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(doctorId)
            .get();

        if (userDoc.exists) {
          double amount = 0.0;
          try {
            amount = double.parse(userDoc.get("balance") ?? "0.0");
            amount = amount + double.parse(withdrawAmount);
          } catch (e) {
            log('Invalid withdrawAmount: $withdrawAmount. Error: $e');
            ToastMsg().toastMsg("Invalid withdraw amount.");
            return; // Exit the method early
          }

          // Update the user's balance
          await FirebaseFirestore.instance
              .collection('users')
              .doc(doctorId)
              .update({
            'balance': amount.toString(),
          });

          ToastMsg().toastMsg("Balance updated successfully.");
        } else {
          log('User document does not exist for doctorId: $doctorId');
          ToastMsg().toastMsg("User not found.");
        }
      }

      ToastMsg().toastMsg("You $newStatus this user");
    } catch (e) {
      log('Error updating doctor status: $e');
      ToastMsg().toastMsg("Failed to update status. Please try again.");
    }
  }

}
