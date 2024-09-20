import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HelpCenterScreen/Components/chat_tile.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HelpCenterScreen/Components/message_bubble.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HelpCenterScreen/Components/message_input.dart';
import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField2(
                    inputController: searchC,
                    hintText: "Search",
                    prefixIcon: Icons.search,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const ChatTile();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: secondaryGreenColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                )
              ),
                child: Column(
                  children: [
                    ListTile(
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
                      title: AppText2(
                        text: "Alexa",
                        fontSize: 14.sp, fontWeight: FontWeight.w500,
                        isTextCenter: false, textColor: themeColor,
                        fontFamily: AppFonts.medium,
                      ),
                      subtitle: AppText2(
                          text: "Online",
                          fontSize: 10.sp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: Colors.grey
                      ),
                    ),
                    const Divider(color: themeColor,),
                    Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: const [
                            MessageBubble(message: "How to use this app?",isSender:  true),
                            MessageBubble(
                                message: "This app is very simple and unique"
                                " to give the appointment to the doctor.",isSender:  false),
                            MessageBubble(message: "How to send Payment?",isSender:  true),
                            MessageBubble(message: "How to use this app?",isSender:  true),
                            MessageBubble(
                                message: "This app is very simple and unique"
                                " to give the appointment to the doctor.",isSender:  false),
                            MessageBubble(message: "How to send Payment?",isSender:  true),
                          ],
                        )
                    ),
                    const MessageInput(),
                    SizedBox(height: 1.h,)
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}


