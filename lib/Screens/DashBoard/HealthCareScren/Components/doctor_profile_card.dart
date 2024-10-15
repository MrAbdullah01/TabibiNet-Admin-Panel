import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';
import 'package:tabibinet_admin_panel/Provider/actionProvider/actionProvider.dart';
import '../../PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';
import '../../../../Model/Res/Constants/app_assets.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_icons.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';

class DoctorProfileCard extends StatelessWidget {
  final DocumentSnapshot users; // Pass DocumentSnapshot here
  const DoctorProfileCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActionProvider>(context);
    final pro = Provider.of<DashBoardProvider>(context);
    final doc = Provider.of<PatientDataProvider>(context);
    final userData = users.data() as Map<String, dynamic>;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            SizedBox(height: 4.h),
            Container(
              width: 200,
              height: 250,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      children: [
                        AppText(
                          text: provider.capitalizeFirstLetter(users['name']),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          isTextCenter: false,
                          textColor: textColor,
                          fontFamily: AppFonts.semiBold,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 10.sp),
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: AppText(
                            text: users["speciality"] ?? 'N/A', // Fallback if null
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            isTextCenter: false,
                            textColor: bgColor,
                          ),
                        ),
                        SizedBox(height: 5.sp),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: secondaryGreenColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(AppIcons.locationIcon, 'Location: ', users["country"] ?? 'N/A'),
                        const SizedBox(height: 6),
                        _buildInfoRow(AppIcons.mailIcon, '', users["email"] ?? 'N/A'),
                        const SizedBox(height: 6),
                        _buildInfoRow(AppIcons.phoneIcon, '', users["phoneNumber"] ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 40,
          backgroundImage:

          users["profileUrl"] != null
              ? NetworkImage(users["profileUrl"])
              :
          AssetImage(AppAssets.doctorImage) as ImageProvider,
        ),
        Positioned(
          right: 12.sp,
          top: 26.sp,
          child: PopupMenuButton(
            icon: SvgPicture.asset(
              AppIcons.verticalMenuIcon,
              height: 12.sp,
            ),
            color: greenColor,
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem(
                  onTap: () {
                    deleteDoctor(users.id);
                  },
                  child: SizedBox(
                    width: 30.sp,
                    child: AppText(
                      text: "Remove",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      isTextCenter: false,
                      textColor: bgColor,
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    // Extract user data to patient data provider
                    doc.setDoctorDataDetails(
                      doctorName: userData['name'] ?? '',
                      doctorDescription: userData['specialityDetail'] ?? '',
                      doctorPhoto: userData['profileUrl'] ?? '',
                      docFees: userData['fees']?.toString() ?? '0',
                      docFeesId: userData['feesId'] ?? '',
                      doctorLocation: userData['country'] ?? '',
                      docPhoneNumber: userData['phoneNumber'] ?? '',
                      docModel: userData,
                    );
                    pro.setSelectedIndex(23);
                  },
                  child: SizedBox(
                    width: 30.sp,
                    child: AppText(
                      text: "Run Add",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      isTextCenter: false,
                      textColor: bgColor,
                    ),
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }

  Row _buildInfoRow(String iconPath, String label, String value) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 13.sp,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11.sp),
          ),
        ),
      ],
    );
  }

  Future<void> deleteDoctor(String id) async {
    await FirebaseFirestore.instance.collection("users").doc(id).delete();
  }
}
