import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/ProfileOption.dart';
import 'chatListScreen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 20,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Edit Profile functionality.
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFFFA768),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 94,
                    width: 94,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/content/profile.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Shruti Saini',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    '+91 8171XXXXXX',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Options
            const SizedBox(height: 24.0),
            ProfileOption(
              icon: Iconsax.lock,
              label: 'Password',
              onTap: () {
                //
              },
              lastIcon: Iconsax.arrow_right_3,
            ),
            ProfileOption(
              icon: Iconsax.message_text,
              label: 'Chats',
              onTap: () {
                Get.to(() => ChatListScreen());
              },
              lastIcon: Iconsax.arrow_right_3,
            ),
            ProfileOption(
              icon: Icons.support_agent,
              label: 'Support',
              onTap: () {
                //  Support option routing
              },
            ),
            ProfileOption(
              icon: Icons.logout,
              label: 'Log out',
              onTap: () {
                // Log out functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
