import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Widgets/toast_msg.dart';
import '../../../../Provider/chatProvider/chatProvider.dart';
import '../../../../Provider/cloudinaryProvider/imageProvider.dart';

class MessageInput extends StatelessWidget {
  final String chatRoomId, otherUserEmail;

   MessageInput({super.key, required this.chatRoomId, required this.otherUserEmail});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(
                fontFamily: AppFonts.medium,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: 'Type a message....',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: AppFonts.medium,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.lightBlue),
            onPressed: () {
              _pickAndUploadImage(context);
            },
          ),
          SizedBox(width: 1.w),
          GestureDetector(
            onTap: () async {
              await provider.sendMessage(
                chatRoomId: chatRoomId,
                message: _controller.text,
                otherEmail: otherUserEmail,
                type: 'text',
              );
              _controller.clear();
            },
            child: CircleAvatar(
              backgroundColor: themeColor,
              child: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Accept only images

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isEmpty) return;

      final reader = html.FileReader();
      reader.readAsArrayBuffer(files[0]);

      reader.onLoadEnd.listen((e) async {
        final bytes = reader.result as Uint8List;

        // Set image data using Provider to display in the container
        final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
        cloudinaryProvider.setImageData(bytes);

        ToastMsg().toastMsg('Image uploaded successfully');
      });
    });

    uploadInput.click(); // Trigger the file picker dialog
  }
}
