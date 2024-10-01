
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';


import 'package:timeago/timeago.dart' as timeago;

import '../../../../Model/Res/Constants/firebase.dart';
import '../../../../Model/Res/Widgets/AppTextField.dart';
import '../../../../Model/Res/components/textWidget.dart';
import '../../../../Provider/chatProvider/chatProvider.dart';

class ChatTypeWidget extends StatelessWidget {
  const ChatTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: Offset(0, 2.0),
            ),
          ]
      ),
      child: Consumer<ChatProvider>(
        builder: (context,provider,child){
          return Column(
            children: [
              // ChatHeader(imageUrl: image, name: name,),
              Expanded(
                child: StreamBuilder(
                  stream: context.read<ChatProvider>().getMessages(
                      provider.chatRoomId.isNotEmpty ? provider.chatRoomId : "ss"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    provider.markMessageAsRead(provider.chatRoomId);
                    provider.updateDeliveryStatus(provider.chatRoomId);
                    final messages = snapshot.data!.docs;
                    List<Widget> messageWidgets = [];
                    for (var message in messages) {
                      final messageText = message["text"];
                      final messageSender = message["sender"];
                      final messageTimestamp = message["timestamp"];
                      final isDelivered = message["delivered"];

                      final relativeTime = messageTimestamp != null
                          ? timeago.format(messageTimestamp.toDate())
                          : '';


                      // return ListView
                      final isCurrentUser = messageSender == auth.currentUser?.uid.toString();

                      final messageWidget = Align(
                        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: isCurrentUser ? themeColor : Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: isCurrentUser
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  SelectableText(
                                    messageText,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        relativeTime,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                      if (isCurrentUser) ...[
                                        SizedBox(width: 5),
                                        Icon(
                                          message["read"] ? Icons.done_all : Icons.done,
                                          color: message["read"] ? Colors.white :  Colors.white70,
                                          size: 12,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if(isCurrentUser)
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: AppTextWidget(text: isDelivered ? "seen" : "Delivered", fontSize:  12.0))
                          ],
                        ),
                      );

                      messageWidgets.add(messageWidget);
                    }
                    return ListView(
                      reverse: true,
                      children: messageWidgets,
                    );
                  },
                ),
              ),
              _buildMessageInput(context,provider,provider.otherUserEmail),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context,ChatProvider provider,String otherEmail) {
    final provider = Provider.of<ChatProvider>(context, listen: false);
    final TextEditingController _controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              inputController: _controller,
              hintText: "Type a message",
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async{
              final text = _controller.text;
              if (text.isNotEmpty) {


                final otherEmails = Provider.of<ChatProvider>(context,listen: false).otherUserEmail;
                log("Other User Email:: ${otherEmails}");
                provider.sendMessage(
                    chatRoomId: provider.chatRoomId, message: text,otherEmail: otherEmail,
                     type: 'text'
                );
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}