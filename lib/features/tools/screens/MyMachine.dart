import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../home/widgets/CustomAppBar.dart';
import '../../profile/screens/profileScreen.dart';
import '../../screens/tools/widgets/toolSearchBar.dart';
import '../widgets/MyMachineCard.dart';
import 'MachineProfileScreen.dart';

class MyMachineScreen extends StatelessWidget {
  const MyMachineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FF),
      appBar: CustomAppBar(
        ActionWidgets: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => ProfileScreen());
            },
            icon: const Icon(Iconsax.profile_circle),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Machine',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Search Bar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column to contain the search bar and its suggestions
                const Expanded(
                  child: Column(
                    children: [
                      Toolsearchbar(),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Icon(Iconsax.setting_4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Listview for all the machines
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with the actual number of items
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => MachineProfile());
                    },
                    child: const MyMachineCard(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
