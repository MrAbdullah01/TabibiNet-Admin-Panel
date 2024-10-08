import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
        required this.text,
        required this.fontSize,
        required this.fontWeight,
         this.isTextCenter,
        required this.textColor,
        this.maxLines,
        this.fontFamily = "Regular",
        this.valueKey,
        this.overflow = TextOverflow.ellipsis,
        this.textDecoration = TextDecoration.none
      });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final bool? isTextCenter;
  final int? maxLines;
  final String fontFamily;
  final ValueKey<int>? valueKey;
  final TextOverflow? overflow;
  final TextDecoration textDecoration;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      minFontSize: 8.0,
      key: valueKey,
      text,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: isTextCenter == true ? TextAlign.center: TextAlign.start,
      style: TextStyle(
          decoration: textDecoration,
          decorationColor: themeColor,
          fontSize: fontSize, fontWeight: fontWeight, color: textColor,fontFamily: fontFamily),);
  }
}

class AppText2 extends StatelessWidget {
  const AppText2(
      {super.key,
        required this.text,
        required this.fontSize,
        required this.fontWeight,
        required this.isTextCenter,
        required this.textColor,
        this.maxLines,
        this.fontFamily = "Regular",
        this.valueKey
      });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final bool isTextCenter;
  final int? maxLines;
  final String fontFamily;
  final ValueKey<int>? valueKey;
  @override
  Widget build(BuildContext context) {
    return Text(
      key: valueKey,
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: isTextCenter == true ? TextAlign.center: TextAlign.start,
      style: TextStyle(
          fontSize: fontSize, fontWeight: fontWeight, color: textColor,fontFamily: fontFamily),);
  }
}
