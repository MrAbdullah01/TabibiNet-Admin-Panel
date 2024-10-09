import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Provider/Appointment/paymentProvider.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Model/data/paymentModel/paymentModel.dart';

class PatientPaymentScreen extends StatelessWidget {
  const PatientPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context,listen: false);
    final pro = Provider.of<DashBoardProvider>(context,listen: false);
    final pData = Provider.of<PatientDataProvider>(context, listen: false);

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
                text: "Patient Payment History",
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
          StreamBuilder<List<PaymentModel>>(
            stream:  payment.fetchAppointments(),
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

              return ListView.separated(
                shrinkWrap: true,
                itemCount: appointments.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  final appointment = appointments[index]; // Get each appointment

                  return Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Provider.of<PatientDataProvider>(context, listen: false).setPatientDataDetails(
                                  patientName: appointment.patientName,
                                  appointmentDate: appointment.appointmentDate,
                                  fees: appointment.fees,
                                  feesId: appointment.feesType,
                                  country: appointment.country,
                                  patientPhone: appointment.patientPhone,
                                  userType: appointment.userType,
                                  patientProblem: appointment.patientProblem,
                                  patientAge: appointment.patientAge,
                                  patientEmail: appointment.email
                                );
                                pro.setSelectedIndex(20);
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image:  DecorationImage(
                                        // image: AssetImage(AppAssets.doctorImage)
                                      image:   appointment.image.isNotEmpty ?
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
                            Column(
                              children: [
                                AppText(
                                  text: appointment.doctorName,
                                  fontSize: 14.sp, fontWeight: FontWeight.w600,
                                  isTextCenter: false, textColor: textColor,
                                  fontFamily: AppFonts.semiBold,),
                                AppText2(
                                  text: appointment.feesType,
                                  fontSize: 11.sp, fontWeight: FontWeight.w600,
                                  isTextCenter: false, textColor: themeColor,
                                  fontFamily: AppFonts.medium,),
                              ],
                            ),
                            const Spacer(),
                            AppText(
                              text: appointment.fees,
                              fontSize: 14.sp, fontWeight: FontWeight.w600,
                              isTextCenter: false, textColor: textColor,
                              fontFamily: AppFonts.semiBold,),
                            const Spacer(),
                            SubmitButton(
                              width: 8.w,
                              height: 40,
                              bgColor: bgColor,
                              textColor: themeColor,
                              title: "Details",
                              press: () {
                                Provider.of<PatientDataProvider>(context, listen: false).setPatientDataDetails(
                                  patientName: appointment.patientName,
                                  appointmentDate: appointment.appointmentDate,
                                  fees: appointment.fees,
                                  feesId: appointment.feesType,
                                  country: appointment.country,
                                  patientPhone: appointment.patientPhone,
                                  userType: appointment.userType,
                                    patientProblem: appointment.patientProblem,
                                    patientAge: appointment.patientAge,
                                    patientEmail: appointment.email
                                );
                                pro.setSelectedIndex(20);
                              },),
                            // SvgPicture.asset(AppIcons.visibleIcon,height: 30,)
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 20,),
              );
            } )
        ],
      ),
    );
  }
}
