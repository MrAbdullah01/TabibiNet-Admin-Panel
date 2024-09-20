import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
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
    return AutoSizeText(
      key: valueKey,
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: isTextCenter == true ? TextAlign.center: TextAlign.start,
      style: TextStyle(
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
