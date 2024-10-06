// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../Model/Res/Constants/app_assets.dart';
// import '../../../../Model/Res/Constants/app_colors.dart';
// import '../../../../Model/Res/Constants/app_fonts.dart';
// import '../../../../Model/Res/Widgets/app_text_widget.dart';
// import '../../../../Provider/chatProvider/chatProvider.dart';
// import 'message_bubble.dart';
// import 'message_input.dart';
//
// class RightSideScreen extends StatelessWidget {
//   final String? chatRoomId;
//   final String? otherUserEmail;
//
//   const RightSideScreen({
//     super.key,
//      this.chatRoomId,
//      this.otherUserEmail,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: secondaryGreenColor,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(15),
//           bottomRight: Radius.circular(15),
//         ),
//       ),
//       child: Consumer<ChatProvider>(
//         builder: (context, chatProvider, child) {
//           return Column(
//             children: [
//               ListTile(
//                 leading: Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     const CircleAvatar(
//                       backgroundImage: AssetImage(AppAssets.profileImage),
//                     ),
//                     Container(
//                       height: 10,
//                       width: 10,
//                       decoration: const BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                     )
//                   ],
//                 ),
//                 title: AppText2(
//                   text: otherUserEmail.toString(), // Use the other user's email
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   isTextCenter: false,
//                   textColor: themeColor,
//                   fontFamily: AppFonts.medium,
//                 ),
//                 subtitle: AppText2(
//                   text: "Online",
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w500,
//                   isTextCenter: false,
//                   textColor: Colors.grey,
//                 ),
//               ),
//               const Divider(color: themeColor),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('chatRooms')
//                       .doc(chatRoomId)
//                       .collection("messages")
//                       .orderBy("timestamp", descending: true)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                       return const Center(child: Text("No messages found"));
//                     }
//
//                     final messages = snapshot.data!.docs;
//
//                     return ListView.builder(
//                       reverse: true, // To show the latest messages at the bottom
//                       itemCount: messages.length,
//                       itemBuilder: (context, index) {
//                         final message = messages[index];
//                         final isSender = message['senderId'] == chatProvider.currentUserId;
//
//                         return MessageBubble(
//                           message: message['text'], // Display the message content
//                           isSender: isSender, // Check if the current user is the sender
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               const MessageInput(),
//               SizedBox(height: 1.h),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Res/Constants/app_assets.dart';
import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../../Model/data/chatModel/messageModel.dart';
import '../../../../Provider/chatProvider/chatProvider.dart';
import 'message_bubble.dart';
import 'message_input.dart';
import 'package:timeago/timeago.dart' as timeago;

class RightSideScreen extends StatelessWidget {
  const RightSideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    // Check if a chat room is selected
    if (chatProvider.selectedChatRoom == null) {
      return Center(child: Text('No chat selected'));
    }
    // Get the selected user's details
    final selectedUser =
        chatProvider.getUserDetailsByEmail(chatProvider.selectedUserEmail!);
    //create scroll controller
    final ScrollController _scrollController = ScrollController();

    // Stream of messages for the selected chat room
    return Column(
      children: [
        ListTile(
          leading: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundImage: selectedUser.profileUrl != null
                    ? NetworkImage(
                        selectedUser.profileUrl!) // Show user's profile picture
                    : const AssetImage(AppAssets.profileImage) as ImageProvider,
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color:
                   selectedUser.isOnline
                       ?Colors.green
                     : Colors.grey, // Show online status
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          title: AppText2(
            text: selectedUser.name ?? "Unknown", // Display user's name
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            isTextCenter: false,
            textColor: themeColor,
            fontFamily: AppFonts.medium,
          ),
          subtitle: AppText2(
            text:
            selectedUser.isOnline
                ? "active"
               :
            "Offline", // Show online status text
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            isTextCenter: false,
            textColor: Colors.grey,
          ),
        ),
        const Divider(color: themeColor),
        Expanded(
          child: StreamBuilder<List<MessageModel>>(
            stream:
                chatProvider.getFMessages(chatProvider.selectedChatRoom!.id),
            builder: (context, snapshot) {
              log("selectedChat room id is:::${chatProvider.selectedChatRoom!.id}");
              log("selectedChatRoom issssssss: ${chatProvider.selectedChatRoom?.id}");
              log("selectedUserEmail issssss: ${chatProvider.selectedUserEmail}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No messages yet'));
              }

              // Display the messages
              var messages = snapshot.data!;
              // Scroll to bottom when new messages arrive
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                }
              });
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final relativeTime = timeago.format(message.timestamp);

                        // Check the type of message
                        if (message.type == 'image' && message.url != null) {
                          // Image message
                          return MessageBubble(
                            profileImageUrl: selectedUser.profileUrl,
                            message:
                                'Image message', // You can show a placeholder or the type of message
                            isSender:
                                message.sender == chatProvider.currentUserId,
                            time: relativeTime,
                            type: message.type,
                            url: message.url, // Show image in MessageBubble
                          );
                        } else if (message.type == 'voice' &&
                            message.url != null) {
                          // Voice message
                          return MessageBubble(
                            profileImageUrl: selectedUser.profileUrl,
                            message:
                                'Voice message', // Placeholder for voice message text
                            isSender:
                                message.sender == chatProvider.currentUserId,
                            time: relativeTime,
                            type: message.type,
                            url: message
                                .url, // Pass the voice URL to the MessageBubble
                          );
                        } else {
                          // Text message
                          return MessageBubble(
                            profileImageUrl: selectedUser.profileUrl,
                            message: message.text,
                            isSender:
                                message.sender == chatProvider.currentUserId,
                            time: relativeTime,
                            type: message.type,
                            url: message
                                .url, // Pass URL if any (for image or voice)
                          );
                        }
                      },
                    ),
                  ),
                  MessageInput(
                    // [log] selectedChatRoom issssssss: usman1903naveed@gmail.com-admin@tabibinet.com
                    chatRoomId: chatProvider.selectedChatRoom!.id,
                    //[log] selectedUserEmail issssss: usman1903naveed@gmail.com
                    otherUserEmail: chatProvider.selectedUserEmail!,
                  ), // Input for sending messages
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
