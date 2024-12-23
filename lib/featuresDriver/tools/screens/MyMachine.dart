import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../home/widgets/CustomAppBar.dart';
import '../../profile/screens/profileScreen.dart';


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
     
    );
  }
}
