import 'package:flutter/material.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_fonts.dart';

class SuggestionContainer extends StatelessWidget {
  const SuggestionContainer({
    super.key,
    required this.text,
     this.boxColor,
    required this.textColor, this.height, this.width, this.radius, this.textSize,
    this.bdRadius, required this.onTap,  this.bdColor, this.overflow, this.bgColor  ,
  });

  final String text;
  final Color? boxColor;
  final Color? textColor,bdColor,bgColor;
  final double? height, width, radius, textSize, bdRadius;
  final Function() onTap;
  final TextOverflow? overflow ;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,

        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: bgColor ?? themeColor,
            borderRadius: BorderRadius.circular(bdRadius ?? 8),
            border: Border.all(
                color: bdColor ?? themeColor
            )
        ),
        child: Center(
          child: AppText(
            text: text, fontSize: 16,
            fontWeight: FontWeight.w500, isTextCenter: false,
            textColor:  textColor ?? Colors.white,
            overflow: overflow,
            fontFamily: AppFonts.medium,),
        ),
      ),
    );
  }
}