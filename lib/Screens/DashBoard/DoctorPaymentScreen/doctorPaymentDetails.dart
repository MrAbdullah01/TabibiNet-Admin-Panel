import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';

class DoctorPaymentDetails extends StatelessWidget {
  const DoctorPaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final pData = Provider.of<PatientDataProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              AppText(
                text: 'Doctor Details',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                textColor: themeColor,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //show patient details
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextCol("Doctor Name:", pData.doctorName),
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextCol('Payment Amount:', 'MAD${pData.fees}'),

                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextCol('Doctor Location:', pData.doctorLocation),

                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextCol('Phone Number:', pData.docPhoneNumber),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget AppTextCol(title, description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 18,
          textColor: themeColor,
          fontWeight: FontWeight.bold,
        ),
        AppText(
          text: description,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
