import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';

import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isSender
  });

  final String message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        constraints: BoxConstraints(maxWidth: 30.w),
        decoration: BoxDecoration(
          color: isSender ? Colors.teal[100] : Colors.blue[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isSender ? const Radius.circular(0) : const Radius.circular(15),
            bottomRight: isSender ? const Radius.circular(15) : const Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              maxLines: null,
              style: const TextStyle(fontSize: 16, color: textColor,fontFamily: AppFonts.medium),
            ),
            SizedBox(height: 1.h,),
            AppText2(
                text: "10:39 Am",
                fontSize: 10.sp, fontWeight: FontWeight.w500,
                isTextCenter: false, textColor: bgColor),
          ],
        ),
      ),
    );
  }
}
