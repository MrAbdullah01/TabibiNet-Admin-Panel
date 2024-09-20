import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_fonts.dart';
import '../Constants/app_icons.dart';
import 'app_text_widget.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.nameText,
    required this.emailText,
    required this.phoneText,
    required this.image,
    required this.isAddIcon,
    required this.isStatusText,
    this.statusText,
    this.addTap,
    this.editTap,
    this.delTap,
  });

  final String nameText;
  final String emailText;
  final String phoneText;
  final String? statusText;
  final String image;
  final bool isAddIcon;
  final bool isStatusText;
  final VoidCallback? addTap;
  final VoidCallback? editTap;
  final VoidCallback? delTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:10.sp,horizontal: 15.sp),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(width: 20.sp,),
          AppText(
            text: nameText,
            fontSize: 14.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: themeColor,
            fontFamily: AppFonts.medium,
          ),
          const Spacer(),
          AppText(
            text: emailText,
            fontSize: 14.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: Colors.grey,
            fontFamily: AppFonts.medium,
          ),
          const Spacer(),
          AppText(
            text: phoneText,
            fontSize: 14.sp, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: Colors.grey,
            fontFamily: AppFonts.medium,
          ),
          const Spacer(),
          Visibility(
            visible: isStatusText,
            child: AppText(
              text: statusText ?? "",
              fontSize: 14.sp, fontWeight: FontWeight.w500,
              isTextCenter: false, textColor: Colors.grey,
              fontFamily: AppFonts.medium,
            ),
          ),
          const Spacer(),
          Row(children: [
            Visibility(
              visible: isAddIcon,
              child: InkWell(
                  onTap: addTap ?? (){},
                  child: SvgPicture.asset(AppIcons.addIcon,height: 4.h,)),
            ),
            SizedBox(width: 10.sp,),
            InkWell(
                onTap: editTap ?? (){},
                child: SvgPicture.asset(AppIcons.pencilIcon,height: 4.h,)),
            SizedBox(width: 10.sp,),
            InkWell(
                onTap: delTap ?? (){},
                child: SvgPicture.asset(AppIcons.deleteIcon,height: 4.h,)),
          ],)

        ],
      ),
    );
  }
}
