import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBubble extends StatelessWidget {
  final String message; // Message text or placeholder for image/voice
  final String type; // Message type (text, image, voice)
  final bool isSender;
  final String time;
  final String? url; // URL for image or voice


  const MessageBubble({
    required this.message,
    required this.type,
    required this.isSender,
    required this.time,
    this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messageContent;

    // Display content based on message type
    if (type == 'text') {
      // Display text message
      messageContent = Text(
        message,
        style: TextStyle(color: isSender ? Colors.white : Colors.black),
      );
    } else if (type == 'image' && url != null) {
      // Display image message
      messageContent = ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url!,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error); // Handle image loading error
          },
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        ),
      );
    } else if (type == 'voice' && url != null) {
      // Display voice message with a clickable play button
      messageContent = GestureDetector(
        onTap: () {
          // Open or play voice message
          launchUrl(url!);
        },
        child: Row(
          children: [
            const Icon(Icons.play_circle_fill, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text(
              url.toString(),
              style: TextStyle(color: isSender ? Colors.white : Colors.black),
            ),
          ],
        ),
      );
    } else {
      // Fallback for unknown message types
      messageContent = Text(
        'Unknown message type',
        style: TextStyle(color: isSender ? Colors.white : Colors.black),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start, // Align right for sender
        children: [
          if (!isSender) // Only show avatar for receiver's message
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Image.asset(AppAssets.profileImage),
            ),
          SizedBox(width: 1.w),
          Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: isSender ? Colors.blueAccent : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: messageContent,
              ),
              const SizedBox(height: 5),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to open URL
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
