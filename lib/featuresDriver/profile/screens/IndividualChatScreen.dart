import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../widgets/ChatBubble.dart';

class IndividualChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/content/profile.png'), // Replace with your asset image
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shruti Saini', style: TextStyle(fontSize: 16.0)),
                Text('Last seen at 5:00 pm',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ChatBubble(
                  message: 'नमस्ते, मुझे तस्वीरें पसंद आईं, अच्छी हैं।',
                  isMe: true,
                  time: '11:00 pm',
                ),
                ChatBubble(
                  message: 'नमस्ते, मुझे तस्वीरें पसंद आईं, अच्छी हैं।',
                  isMe: false,
                  time: '11:00 pm',
                ),
                ChatBubble(
                  message: '''
                  नमस्ते, मुझे तस्वीरें पसंद आईं, अच्छी हैं।
                  नमस्ते, मुझे तस्वीरें पसंद आईं, अच्छी हैं।
                  नमस्ते, मुझे तस्वीरें पसंद आईं, अच्छी हैं।''',
                  isMe: true,
                  time: '11:01 pm',
                ),
                ChatBubble(
                  message: 'नमस्ते, मुझे तस्वीरें पसंद आईं, अच्छी हैं।',
                  isMe: false,
                  time: '11:01 pm',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.orange),
                  onPressed: () {
                    // Handle send message action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
