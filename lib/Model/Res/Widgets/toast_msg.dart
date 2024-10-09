import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants/app_colors.dart';

class ToastMsg{
  void toastMsg(String msg,{Color? toastColor}){
    Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: toastColor ?? themeColor,
        textColor: bgColor,
        fontSize: 12
    );
  }
}