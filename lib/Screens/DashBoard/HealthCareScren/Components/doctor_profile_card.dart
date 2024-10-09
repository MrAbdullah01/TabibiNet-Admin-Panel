import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/firebase.dart';

import '../../../../Model/Res/Constants/app_assets.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_icons.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';

class DoctorProfileCard extends StatelessWidget {
  final users;
  const DoctorProfileCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
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
                          text: users['name'],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          isTextCenter: false,
                          textColor: textColor,
                          fontFamily: AppFonts.semiBold,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.sp, horizontal: 10.sp),
                          decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: AppText(
                              text: users["speciality"],
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              isTextCenter: false,
                              textColor: bgColor),
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
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
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.locationIcon,
                              height: 14.sp,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Location: ',
                              style: TextStyle(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                                child: Text(
                              users["country"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.mailIcon,
                              width: 13.sp,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                                child: Text(
                              users["email"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.sp),
                            )),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.phoneIcon,
                              width: 13.sp,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              users["phoneNumber"],
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: users["profileUrl"] != null
                      ? NetworkImage(users["profileUrl"])
                      : AssetImage(AppAssets.doctorImage))),
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
                          textColor: bgColor),
                    )),
              ];
            },
          ),
        ),
      ],
    );
  }
  Future<void> deleteDoctor(id)async{
    fireStore.collection("users").doc(id).delete();
  }
}
