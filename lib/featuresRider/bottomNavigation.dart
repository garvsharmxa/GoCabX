import 'package:buzzcab/featuresRider/screen/bookRides/ridebook_page.dart';
import 'package:buzzcab/featuresRider/screen/profile/rider_profile.dart';
import 'package:buzzcab/featuresRider/screen/savedRide/saved_place.dart';
import 'package:buzzcab/featuresRider/screen/setting/rider_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'screen/homePage/homepage.dart';

class RiderNavigationMenu extends StatelessWidget {
  const RiderNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => ClipRRect(
          borderRadius: BorderRadius.only(
            
            topLeft: Radius.circular(22.0),
            topRight: Radius.circular(22.0)
          ),
          child: BottomNavigationBar(
          
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              if (index == 2) {
                controller.selectedIndex.value = index;
                
               
              } else {
                controller.selectedIndex.value = index;
              }
            },
            type: BottomNavigationBarType.fixed,
            
            selectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            unselectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade400
                : Colors.grey,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : const Color(0xFFE6E6E6),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            
            items: [
              BottomNavigationBarItem(
                icon: _buildIconWithBackground(
                  'assets/icons/homepage/home-variant-outline.svg',
                  controller.selectedIndex.value == 0,
                  context,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithBackground(
                  'assets/icons/homepage/saved.svg',
                  controller.selectedIndex.value == 1,
                  context,
                ),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: _buildCenterButton(context),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithBackground(
                  'assets/icons/homepage/cog-outline.svg',
                  controller.selectedIndex.value == 3,
                  context,
                ),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithBackground(
                  'assets/icons/homepage/account-circle-outline.svg',
                  controller.selectedIndex.value == 4,
                  context,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithBackground(String assetPath, bool isSelected, BuildContext context) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              shape: BoxShape.circle,
            )
          : null,
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        assetPath,
        color: isSelected
            ? Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white
            : Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
      ),
    );
  }

  Widget _buildCenterButton(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFD4D4D4)
,
        shape: BoxShape.circle,
       
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/homepage/map-marker-distance.svg',
          // color: Colors.white,
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const SavedPlace(),
    const RidebookPage(),
    const RiderSetting(),
     const RiderProfile(),
  ];
}
