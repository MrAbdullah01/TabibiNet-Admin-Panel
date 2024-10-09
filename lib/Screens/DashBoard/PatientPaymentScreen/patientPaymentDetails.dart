import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';

class PatientPaymentDetails extends StatelessWidget {
  const PatientPaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final pData = Provider.of<PatientDataProvider>(context);
    // Calculate total payment including VAT
    var originalAmount = double.parse(pData.fees); // Original fee amount
    double vatRate = 0.20; // VAT rate (20%)
    double totalAmount = originalAmount + (originalAmount * vatRate);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              AppText(
                text: 'Patient Details',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //show patient details
                        SizedBox(
                          height: 2.h,
                        ),

                        AppTextCol("Patient Name:", pData.patientName),
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextCol('Payment Amount:', 'MAD $totalAmount (including 20% VAT)'),
                        SizedBox(
                          height: 2.h,
                        ),

                        AppTextCol('Patient Email:', pData.patientEmail),
                        SizedBox(
                          height: 2.h,
                        ),

                      ],
                    ),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextCol('Patient Problem:', pData.patientProblem),
                        SizedBox(
                          height: 2.h,
                        ),
                        AppTextCol('Patient Age:', pData.patientAge),

                        SizedBox(
                          height: 2.h,
                        ), AppTextCol('Patient Phone:', pData.patientPhone),

                        SizedBox(
                          height: 2.h,
                        ),
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
