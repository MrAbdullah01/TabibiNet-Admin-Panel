import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/loadingButton.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/suggestionContainer.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/add_button.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/actionProvider/actionProvider.dart';
import '../PatientScreen/Components/patient_field.dart';

class AppointmentFeeScreen extends StatelessWidget {
  AppointmentFeeScreen({super.key});

  final feeNameC = TextEditingController();
  final descriptionC = TextEditingController();
  final priceC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(
                text: "Fees Information",
                fontSize: 14.sp, fontWeight: FontWeight.w500,
                isTextCenter: false, textColor: textColor,
                fontFamily: AppFonts.semiBold,),
              SizedBox(width: 3.w,),
            ],
          ),
          SizedBox(height: 20.sp,),
          Row(
            children: [
              PatientField(text: "Fee Name", textEditingController: feeNameC),
              SizedBox(width: 8.w,),
              PatientField(text: "Description", textEditingController: descriptionC),
            ],
          ),
          SizedBox(height: 20.sp,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PatientField(text: "Price", textEditingController: priceC),
              SizedBox(width: 8.w,),
              HoverLoadingButton(text: 'Submit Now',
                  onClicked: () async{
                    _uploadAppointmentFee(context);
                  },
                  isIcon: false,
                  radius: 8,
                  width: 10.w,
                  height: 5.h),

            ],
          ),
          SizedBox(height: 20.sp,),
          AppText(
            text: "Recent Add",
            fontSize: 14.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: textColor,
            fontFamily: AppFonts.semiBold,),
          SizedBox(height: 10.sp,),
          SizedBox(
              width: 40.w,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('feeInformation')
                      .orderBy('id', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Error appointmentFee specialties.'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No appointmentFee found.'));
                    }

                    var appointmentFee = snapshot.data!.docs;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: appointmentFee.length,
                      itemBuilder: (context, index) {
                        var model = appointmentFee[index];

                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: themeColor
                              )
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 15.w,
                                    child: AppText(
                                      text: model["type"],
                                      fontSize: 12.sp, fontWeight: FontWeight.w500,
                                      isTextCenter: false, textColor: textColor,
                                      fontFamily: AppFonts.medium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                    child: AppText(
                                      text: model["subTitle"],
                                      fontSize: 10.sp, fontWeight: FontWeight.w500,
                                      isTextCenter: false, textColor: textColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],),
                              const Spacer(),
                              SuggestionContainer(
                                text: "${model["fees"]}MAD",
                                height: 35,
                                width: 8.w,
                                radius: 6,
                                textColor: themeColor,
                                bgColor: const Color(0xffE6F4F2),
                                overflow: TextOverflow.ellipsis,
                                onTap: () {

                                },),
                              Padding(
                                padding:  EdgeInsets.only(left: 2.w,right: 1.w),
                                child: InkWell(
                                    onTap:  (){
                                      deleteFeeInfo(context,model['id']);
                                    },
                                    child: SvgPicture.asset(AppIcons.deleteIcon,height: 4.h,)),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 20,),
                    );})
          ),
          ])
    );
  }
  void _uploadAppointmentFee(BuildContext context) {
    var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    if (
    feeNameC.text.isNotEmpty ||
    descriptionC.text.isNotEmpty ||
    priceC.text.isNotEmpty
    ) {
      ActionProvider.startLoading();
      var feeType = FirebaseFirestore.instance
          .collection('feeInformation')
          .doc(timeStamp);

      feeType.set({
        'fees': priceC.text.toString(),
        'subTitle': descriptionC.text.toString(),
        'type': feeNameC.text.toString(),
        'id': timeStamp,
      }).then((value) {
        ActionProvider.stopLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data Uploaded!')),
        );
      }).catchError((error) {
        ActionProvider.stopLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Occurred: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all fields')),
      );
    }
  }

  void deleteFeeInfo(context,String userID) {
    log("user id is:::${userID}");
    FirebaseFirestore.instance
       .collection('feeInformation')
       .doc(userID)
       .delete()
       .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Appointment Fee deleted!')),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error Occurred: $error')),
          );
        });
  }

}
