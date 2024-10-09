import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/data/paymentModel/paymentModel.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/DoctorPaymentScreen/Components/invoice_dialogue_card.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/Appointment/paymentProvider.dart';
import '../../../Provider/DoctorPayment/doctor_payment_provider.dart';
import '../PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';

class DoctorPaymentScreen extends StatelessWidget {
  const DoctorPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DashBoardProvider>(context);
    final paymentProvider = Provider.of<PaymentProvider>(context); // Access the payment provider
    final pData = Provider.of<PatientDataProvider>(context,);


    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Doctor Payment History",
                fontSize: 16.sp, fontWeight: FontWeight.w600,
                isTextCenter: false, textColor: themeColor,
                fontFamily: AppFonts.semiBold,
              ),
              const DefaultTabController(
                length: 3,
                child: SizedBox(
                width: 280,
                child: TabBar(
                    labelStyle: TextStyle(fontFamily: AppFonts.medium),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        text: "Monthly",
                      ),
                      Tab(
                        text: "Weekly",
                      ),
                      Tab(
                        text: "Today",
                      ),
                    ]),
              ),)
            ],
          ),
          Consumer2<DoctorPaymentProvider,PaymentProvider>(
            builder: (context, value, payment,child) {
              return StreamBuilder<List<PaymentModel>>(
                stream: payment.fetchAppointments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No appointments available"));
                  }

                  final appointments = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: appointments.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final isSelected = value.selectIndex == index;
                      final appointment = appointments[index]; // Get each appointment
                      return Container(
                        width: 100.w,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: isSelected ? greyColor : bgColor,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Provider.of<PatientDataProvider>(context, listen: false).setDoctorDataDetails(
                                      doctorName: appointment.doctorName,
                                      fees: appointment.fees,
                                      feesId: appointment.feesType,
                                      docPhoneNumber: appointment.docPhoneNumber,
                                      doctorLocation: appointment.doctorLocation,
                                    );
                                    pro.setSelectedIndex(21);
                                  },

                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image:  DecorationImage(
                                            image:
                                            appointment.image.isNotEmpty ?
                                            NetworkImage(appointment.image):
                                            AssetImage(AppAssets.doctorImage)
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: 1.w,),
                                AppText(
                                  text: appointment.doctorName,
                                  fontSize: 14.sp, fontWeight: FontWeight.w600,
                                  isTextCenter: false, textColor: textColor,
                                  fontFamily: AppFonts.semiBold,),
                                const Spacer(),
                                AppText(
                                  text: appointment.appointmentDate,
                                  fontSize: 14.sp, fontWeight: FontWeight.w600,
                                  isTextCenter: false, textColor: textColor,
                                  fontFamily: AppFonts.semiBold,),
                                const Spacer(),
                                AppText(
                                  text: "MAD ${appointment.fees}",
                                  fontSize: 14.sp, fontWeight: FontWeight.w600,
                                  isTextCenter: false, textColor: textColor,
                                  fontFamily: AppFonts.semiBold,),
                                const Spacer(),
                                SubmitButton(
                                  width: 8.w,
                                  height: 40,
                                  bgColor: greenColor,
                                  textColor: bgColor,
                                  bdColor: greenColor,
                                  title: appointment.status,
                                  press: () {

                                  },),
                                SizedBox(width: 1.w,),
                                IconButton(
                                    onPressed: () {
                                      value.setIndex(index);
                                      //pro.setSelectedIndex(17);
                                    },
                                    icon: Icon(
                                      isSelected ?
                                      CupertinoIcons.chevron_up :
                                      CupertinoIcons.chevron_down,
                                      color: Colors.grey,)
                                )
                                // SvgPicture.asset(AppIcons.visibleIcon,height: 30,)
                              ],
                            ),
                            Visibility(
                                visible: isSelected,
                                child: const Divider(color: Colors.grey,)),
                            Visibility(
                              visible: isSelected,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   PayText(text1: "ID Payment", text2: appointment.id),
                                   PayText(text1: "Date Paid", text2: appointment.appointmentDate),
                                   PayText(text1: "Invoice Date", text2: appointment.appointmentDate),
                                  SubmitButton(
                                    title: "Check Invoice",
                                    height: 30,
                                    textSize: 10.sp,
                                    width: 8.w,
                                    press: () {
                                      Provider.of<PatientDataProvider>(context, listen: false).setDoctorDataDetails(
                                        doctorName: appointment.doctorName,
                                        fees: appointment.fees,
                                        feesId: appointment.feesType,
                                        docPhoneNumber: appointment.docPhoneNumber,
                                        doctorLocation: appointment.doctorLocation,
                                      );
                                      pro.setSelectedIndex(19);
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context){
                                      //     return InvoiceDialogueCard();
                                      // }
                                      // );
                                    },)
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );

                },
              );
            },)
        ],
      ),
    );
  }
}

class PayText extends StatelessWidget {
  const PayText({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
            text: text1,
            fontSize: 10.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: textColor
        ),
        AppText(
            text: text2,
            fontSize: 10.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: textColor)

      ],
    );
  }
}

//Column(
//                 children: [
//                   AppText(
//                       text: "Monthly  Weekly  Today",
//                       fontSize: 12.sp, fontWeight: FontWeight.w600,
//                       isTextCenter: false, textColor: Colors.grey),
//                   SizedBox(width: 13.w,child: const Divider(color: Colors.grey,))
//                 ],
//               )