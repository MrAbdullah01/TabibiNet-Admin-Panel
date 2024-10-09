import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Provider/Appointment/appointment_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentDetailScreen/appointment_detail_screen.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/AppointmentScreen/Components/appointment_card.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/DashBoard/dash_board_provider.dart';
import '../PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';
import 'Components/model/appointmentModel.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({super.key});

  final List<String> status = [
    "upcoming",
    "pending",
    "complete",
    "Cancel",
  ];
  @override
  Widget build(BuildContext context) {
    final appointmentP = Provider.of<AppointmentProvider>(context, listen: false);
    final pro = Provider.of<DashBoardProvider>(context);

    return Consumer<AppointmentProvider>(
      builder: (context, value, child) {
        return  ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 60,
                    width: 100.w,
                    child: Consumer<AppointmentProvider>(
                      builder: (context, value, child) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: status.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: 50,
                                  crossAxisSpacing: 100),
                          itemBuilder: (context, index) {
                            final isSelected = value.selectStatus == index;
                            return SubmitButton(
                              title: status[index].toLowerCase(),
                              bgColor: isSelected ? themeColor : bgColor,
                              textColor: isSelected ? bgColor : themeColor,
                              radius: 6,
                              press: () {
                                value.updateFilter(status[index].toString().toLowerCase());
                                value.setStatus(index);

                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('appointment')
                      .where("status" ,isEqualTo: value.changeFilter)
                         // .orderBy('id', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error fetching appointments.'));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No appointment found.'));
                        }

                        //var appointment = snapshot.data!.docs;
                        var appointments = snapshot.data!.docs.map((doc) {
                          // Use the model to map the data
                          return AppointmentDetails.fromMap(doc.data() as Map<String, dynamic>);
                        }).toList();

                        return ListView.separated(
                          
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            var appointment = appointments[index];

                            // Convert timestamp to DateTime
                            DateTime appointmentTime = DateTime.fromMillisecondsSinceEpoch(int.parse(appointment.id));

                            // Format the DateTime to mm/dd/yyyy
                            String formattedTime = DateFormat('dd MMM,yyyy    hh:mm a').format(appointmentTime);

                            return Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Provider.of<PatientDataProvider>(context, listen: false).setPatientDataDetails(
                                          patientName: appointment.patientName,
                                          appointmentDate: appointment.appointmentTime,
                                          fees: "0.0",
                                          feesId: appointment.id,
                                          country: appointment.doctorLocation,
                                          patientPhone: appointment.patientPhone,
                                          userType: "N/A",
                                          patientProblem: "N/A",
                                          patientAge: "N/A",
                                          patientEmail: appointment.patientEmail);
                                      pro.setSelectedIndex(20);
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image:  DecorationImage(
                                            image: appointment.image.isNotEmpty
                                                ? NetworkImage(appointment.image)
                                              : AssetImage(
                                                   AppAssets.doctorImage),
                                          ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  AppText(
                                    text: appointment.patientName,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    isTextCenter: false,
                                    textColor: textColor,
                                    fontFamily: AppFonts.semiBold,
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.clockIcon,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          AppText(
                                              text: formattedTime,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              isTextCenter: false,
                                              textColor: textColor)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      AppText(
                                        text: appointment.doctorName,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        isTextCenter: false,
                                        textColor: themeColor,
                                        fontFamily: AppFonts.semiBold,
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.smsIcon,
                                            height: 17,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          AppText(
                                              text: appointment.patientEmail,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              isTextCenter: false,
                                              textColor: textColor)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.phone2Icon,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          AppText(
                                              text: appointment.patientPhone,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              isTextCenter: false,
                                              textColor: textColor)
                                        ],
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  SizedBox(width: 3.w,),
                                  InkWell(
                                      onTap: () {
                                        appointmentP.setSelectedAppointment(appointment);
                                        appointmentP.setAppointmentScreen(true);
                                        pro.setSelectedIndex(17);

                                       //  Get.to(
                                       //     AppointmentDetailScreen(),
                                       // );

                                        },
                                      child: SvgPicture.asset(
                                        AppIcons.visibleIcon,
                                        height: 30,
                                      )),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                        );
                      }),
                ],
              );
      },
    );
  }
}
