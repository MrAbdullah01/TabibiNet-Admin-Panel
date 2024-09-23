import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool softWrap;
  final Color? color;
  final ValueKey? keyValue;
  TextDecoration? textDecoration;
  TextOverflow? overflow;
  AppTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
    this.textDecoration,
    this.fontSize = 12,
    this.softWrap = true,
    this.keyValue,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      maxFontSize: fontSize,
      key: keyValue,
      minFontSize: 8.0,
      //AppLocalizations.of(context)?.translate(text) ?? text,
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow ?? TextOverflow.clip,
      style: TextStyle(
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: Colors.black,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color?? Colors.black ,
      ),
    );
  }
}