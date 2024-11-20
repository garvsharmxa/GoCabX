import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/ChatListItem.dart';
import 'IndividualChatScreen.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Chats'),
        automaticallyImplyLeading: false,
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black),
          onPressed: () {
            Get.back();
            // I didn't know how to use. On putting HomeScreen, This will show the HomeScreen but not with the bottom navigation bar.
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.edit),
            onPressed: () {
              // new chat action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual count of chats
        itemBuilder: (context, index) {
          return ChatListItem(
            name: 'Shruti Saini',
            lastMessage: "नमस्ते, मुझे तस्वीरें और हर्रो की स्थिति पसंद आई।",
            time: '5 min',
            isRead: index % 2 == 0,
            onTap: () {
              Get.to(() => IndividualChatScreen());
            },
          );
        },
      ),
    );
  }
}
