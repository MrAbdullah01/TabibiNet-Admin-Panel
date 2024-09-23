import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Res/Constants/app_assets.dart';
import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(AppAssets.profileImage),
          ),
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle
            ),
          )
        ],
      ),
      title: AppText(
          text: "Alexa",
          fontSize: 12.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: themeColor
      ),
      subtitle: AppText(
          text: "How to Send Payment? ",
          fontSize: 10.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: Colors.grey
      ),
      trailing: AppText(
          text: "10:39 Am",
          fontSize: 10.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: Colors.grey
      ),
    );
  }
}
