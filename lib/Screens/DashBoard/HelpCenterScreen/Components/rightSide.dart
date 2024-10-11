import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/data/chatModel/chatRoomModel.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../Model/Res/Constants/app_assets.dart';
import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/firebase.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../../Model/data/chatModel/messageModel.dart';
import '../../../../Provider/chatProvider/chatProvider.dart';
import 'message_bubble.dart';
import 'message_input.dart';

class RightSideScreen extends StatelessWidget {
  const RightSideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("Message:: Widget Rebuild");

    // Use Selector to minimize rebuilds and only rebuild this part when `selectedChatRoom` changes
    return Selector<ChatProvider, ChatRoomModel?>(
      selector: (_, provider) => provider.selectedChatRoom,
      builder: (context, selectedChatRoom, child) {
        if (selectedChatRoom == null) {
          return const Center(child: Text('No chat selected'));
        }

        final chatProvider = Provider.of<ChatProvider>(context, listen: false);
        final selectedUser = chatProvider.getUserDetailsByEmail(chatProvider.selectedUserEmail!);

        // Move ScrollController to avoid re-initializing it on every rebuild
        final ScrollController _scrollController = ScrollController();

        return Column(
          children: [
            ListTile(
              leading: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundImage: selectedUser.profileUrl.isNotEmpty
                        ? NetworkImage(selectedUser.profileUrl)
                        : const AssetImage(AppAssets.profileImage) as ImageProvider,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: selectedUser.isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              title: AppText2(
                text: selectedUser.name ?? "Unknown",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                isTextCenter: false,
                textColor: themeColor,
                fontFamily: AppFonts.medium,
              ),
              subtitle: AppText2(
                text: selectedUser.isOnline ? "Active" : "Offline",
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                isTextCenter: false,
                textColor: Colors.grey,
              ),
              trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert, size: 24.0, color: themeColor),
                color: greenColor,
                itemBuilder: (context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      onTap: () => deleteChat(selectedChatRoom.id),
                      child: SizedBox(
                        width: 30.sp,
                        child: AppText(
                          text: "Delete Chat",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          isTextCenter: false,
                          textColor: themeColor,
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ),
            const Divider(color: themeColor),
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: chatProvider.getFMessages(selectedChatRoom.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No messages yet'));
                  }

                  var messages = snapshot.data!;

                  // Scroll to the bottom when new messages arrive
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    }
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final relativeTime = timeago.format(message.timestamp);

                      // Display different types of messages (text, image, voice, etc.)
                      return MessageBubble(
                        profileImageUrl: selectedUser.profileUrl,
                        message: message.type == 'image'
                            ? 'Image message'
                            : message.type == 'voice'
                            ? 'Voice message'
                            : message.text,
                        isSender: message.sender == chatProvider.currentUserId,
                        time: relativeTime,
                        type: message.type,
                        url: message.url,
                      );
                    },
                  );
                },
              ),
            ),
            MessageInput(
              chatRoomId: selectedChatRoom.id,
              otherUserEmail: chatProvider.selectedUserEmail!,
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteChat(String id) async {
    await fireStore.collection("chatRooms").doc(id).delete();
    Get.back(); // Close the screen after deletion
  }
}

