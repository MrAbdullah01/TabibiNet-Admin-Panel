import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/firebase.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HelpCenterScreen/Components/chat_tile.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HelpCenterScreen/Components/message_bubble.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/HelpCenterScreen/Components/message_input.dart';
import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/constants.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/image_loader.dart';
import '../../../Model/data/chatModel/chatRoomModel.dart';
import '../../../Model/data/chatModel/userChatModel.dart';
import '../../../Provider/chatProvider/chatProvider.dart';
import 'Components/chatController.dart';
import 'Components/rightSide.dart';

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatSearchController());

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextField2(
                    inputController: searchC,
                    hintText: "Search",
                    prefixIcon: Icons.search,
                    onChanged: (value) {
                      controller.updateSearchQuery(value);
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<ChatProvider>(
                    builder: (context, chatProvider, _) {
                      return Obx(() {
                        final searchQuery = controller.searchQuery.value.toLowerCase();
                        return StreamBuilder<List<ChatRoomModel>>(
                          stream: chatProvider.getChatRoomsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
                                child: Text('No chats available'.tr),
                              );
                            }

                            var chatRooms = snapshot.data!
                                .where((chatRoom) {
                              var otherUserEmail = chatRoom.users
                                  .firstWhere((user) => user != auth.currentUser?.uid);
                              var otherUser = chatProvider.users.firstWhere(
                                    (user) => user.email == otherUserEmail,
                                orElse: () => UserchatModel(
                                  id: '',
                                  name: 'Unknown',
                                  email: otherUserEmail,
                                  profileUrl: '',
                                  userUid: '',
                                ),
                              );
                              return otherUser.name.toLowerCase().contains(searchQuery);
                            }).toList();

                            if (chatRooms.isEmpty) {
                              return const Center(
                                child: Text('No chats match the search criteria'),
                              );
                            }

                            return ListView.separated(
                              itemCount: chatRooms.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index >= chatRooms.length) {
                                  return const SizedBox.shrink();
                                }
                                final chatRoom = chatRooms[index];
                                final unreadCount = chatProvider.unreadMessageCounts[chatRoom.id] ?? 0;
                                var otherUserEmail = chatRoom.users
                                    .firstWhere((user) => user != auth.currentUser?.uid);
                                var lastMessage = chatRoom.lastMessage;
                                var timeStamp = chatRoom.lastTimestamp;

                                var otherUser = chatProvider.users.firstWhere(
                                      (user) => user.email == otherUserEmail,
                                  orElse: () => UserchatModel(
                                    id: '',
                                    name: 'Unknown',
                                    email: otherUserEmail,
                                    profileUrl: '',
                                    userUid: '',
                                  ),
                                );

                                return Container(
                                  color: themeColor.withOpacity(0.1),
                                  child: ListTile(
                                    style: ListTileStyle.list,
                                    leading: CircleAvatar(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30.0),
                                        child: ImageLoaderWidget(imageUrl: otherUser.profileUrl,),
                                      ),
                                    ),
                                    title: AppText(
                                      text: otherUser.name,
                                      fontSize: 14.0,
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 1,
                                    ),
                                    subtitle: AppText(
                                      text: lastMessage ?? '',
                                      fontSize: 12.0,
                                      maxLines: 1,
                                      textColor: Colors.grey, fontWeight:  FontWeight.normal,
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        AppText(
                                          text: timeStamp != null ? convertTimestamp(timeStamp.toString()) : '',
                                          fontSize: 12.0,
                                          textColor: Colors.black,
                                          fontWeight:  FontWeight.normal,
                                        ),
                                        const SizedBox(height: 10.0),
                                        unreadCount > 0
                                            ? CircleAvatar(
                                          radius: 7,
                                          backgroundColor: themeColor,
                                        )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                    onTap: () async {
                                      // final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(otherUserEmail, "");
                                      // Provider.of<ChatProvider>(context,listen: false).setResponse(
                                      //     chatRoomId: chatRoomId,
                                      //     otherUserEmail: otherUserEmail
                                      // );
                                      // await chatProvider.getUnreadMessageCount(chatRoom.id);
                                      // log("message ${ chatProvider.getUnreadMessageCount(chatRoom.id).toString()}");
                                      // context.read<ChatProvider>().updateMessageStatus(chatRoomId);
                                      // //show data to right side
                                      // Get.to(
                                      //     RightSideScreen(
                                      //   chatRoomId: chatRoom.id,
                                      //   otherUserEmail: otherUserEmail,
                                      // ));
                                      final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(otherUserEmail, "");
                                      final selectedChatRoom = chatRooms[index]; // Get the selected chat room

                                      // Set the selected chat room and user in the ChatProvider
                                      context.read<ChatProvider>().setSelectedChatRoom(selectedChatRoom, otherUserEmail);

                                      // Update message status and unread count
                                      await chatProvider.getUnreadMessageCount(selectedChatRoom.id);
                                      context.read<ChatProvider>().updateMessageStatus(chatRoomId);
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: Colors.grey,
                                );
                              },
                            );
                          },
                        );
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: RightSideScreen()
          )
        ],
      ),
    );
  }
}


