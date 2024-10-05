import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc('XcZeK5QjfBpZkrp03pGD')
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error loading profile'));
        }

        final profileData = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "View Profile",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              isTextCenter: false,
              textColor: themeColor,
              fontFamily: AppFonts.semiBold,
            ),
            SizedBox(height: 3.h),
            Container(
              padding: const EdgeInsets.all(20),
              width: 100.w,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: profileData['imageUrl'] != null
                        ? NetworkImage(profileData['imageUrl'])
                        : const AssetImage(AppAssets.profileImage) as ImageProvider,
                  ),
                  SizedBox(width: 1.w),
                  AppText(
                    text: profileData['firstName'] ?? 'N/A',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    isTextCenter: false,
                    textColor: themeColor,
                    fontFamily: AppFonts.semiBold,
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 120,
                    child: VerticalDivider(color: themeColor),
                  ),
                  SizedBox(width: 1.w),
                  SizedBox(
                    width: 20.w,
                    child: Column(
                      children: [
                        RowText(
                          text1: "Phone:",
                          text2: profileData['phoneNumber'] ?? 'N/A',
                        ),
                        SizedBox(height: 1.h),
                        RowText(
                          text1: "Email:",
                          text2: profileData['email'] ?? 'N/A',
                        ),
                        SizedBox(height: 1.h),
                        RowText(
                          text1: "Address:",
                          text2: profileData['address'] ?? 'N/A',
                        ),
                        SizedBox(height: 1.h),
                        RowText(
                          text1: "Gender:",
                          text2: profileData['gender'] ?? 'N/A',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText2(
          text: text1,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          isTextCenter: false,
          textColor: textColor,
          fontFamily: AppFonts.medium,
        ),
        AppText2(
          text: text2,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          isTextCenter: false,
          textColor: themeColor,
          fontFamily: AppFonts.medium,
        ),
      ],
    );
  }
}
