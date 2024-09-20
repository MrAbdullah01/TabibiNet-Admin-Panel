import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: TextField(
              style: TextStyle(
                  fontFamily: AppFonts.medium,
                  color: textColor
              ),
              decoration: InputDecoration(
                hintText: 'Type a message....',
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontFamily: AppFonts.medium,
                    color: Colors.grey
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.lightBlue),
            onPressed: () {},
          ),
          SizedBox(width: 1.w,),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.lightBlue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
