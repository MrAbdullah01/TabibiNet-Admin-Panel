import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_fonts.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController inputController;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final String? hintText;
  final int? maxLines, maxLength;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText,readOnly;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.inputController,
    this.type,
    this.maxLines = 1,
    this.textInputAction,
    this.hintText,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false, this.validator,  this.readOnly= false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: type,
      style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.medium
      ),
      validator: validator,
      cursorColor: themeColor,
      controller: inputController,
      maxLength: maxLength,
      textAlign: TextAlign.start,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: greyColor,
            fontFamily: AppFonts.medium
        ),
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: themeColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: themeColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: greyColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class AppTextField2 extends StatelessWidget {
  final TextEditingController inputController;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final String? hintText;
  final int? maxLines, maxLength;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const AppTextField2({
    super.key,
    required this.inputController,
    this.type,
    this.maxLines = 1,
    this.textInputAction,
    this.hintText,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: type,
      style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.medium
      ),
      cursorColor: themeColor,
      validator: (value) {
        if(value!.isEmpty){
          return "Enter the Field";
        }else{
          return null;
        }
      },
      controller: inputController,
      maxLength: maxLength,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon,color: greyColor,),
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: greyColor,
            fontFamily: AppFonts.medium
        ),
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: themeColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: themeColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: greyColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class AppTextField3 extends StatelessWidget {
  final TextEditingController inputController;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? labelText;
  final int? maxLines, maxLength;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  const AppTextField3({
    super.key,
    required this.inputController,
    this.type,
    this.maxLines = 1,
    this.textInputAction,
    this.hintText,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: type,
      style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.medium
      ),
      validator: (value) {
        if(value!.isEmpty){
          return "Enter the Field";
        }else{
          return null;
        }
      },
      cursorColor: themeColor,
      controller: inputController,
      maxLength: maxLength,
      textAlign: TextAlign.start,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        label: AppText(
            text: labelText ?? "",
            fontSize: 12.sp, fontWeight: FontWeight.w400,
            isTextCenter: false, textColor: textColor),
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: greyColor,
            fontFamily: AppFonts.medium
        ),
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: themeColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: themeColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: greyColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}