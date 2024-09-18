import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/add_button.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
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
              SizedBox(width: 1.w,),
              AddButton(
                onTap: () {

              },)
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
              SubmitButton(
                width: 10.w,
                title: "Add Now",
                press: () {

                },),
            ],
          ),
          SizedBox(height: 20.sp,),
          AppText(
            text: "Recent Add",
            fontSize: 14.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: textColor,
            fontFamily: AppFonts.semiBold,),
          SizedBox(height: 20.sp,),
          SizedBox(
            width: 30.w,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: greenColor
                    )
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Video Consultation",
                            fontSize: 12.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,
                            fontFamily: AppFonts.medium,
                          ),
                          AppText(
                            text: "Healthcare services at your home.",
                            fontSize: 10.sp, fontWeight: FontWeight.w500,
                            isTextCenter: false, textColor: textColor,
                          ),
                        ],),
                      const Spacer(),
                      SubmitButton(
                        title: "120 MAD",
                        height: 35,
                        width: 8.w,
                        textColor: themeColor,
                        bdColor: greenColor.withOpacity(0.5),
                        bgColor: greenColor.withOpacity(0.5),
                        press: () {

                        },)
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20,),
            ),
          )

        ],
      ),
    );
  }
}
