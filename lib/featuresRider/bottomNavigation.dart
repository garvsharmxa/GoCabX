import 'package:buzzcab/features/Drawer/Screen/DrawerPage.dart';
import 'package:buzzcab/featuresRider/screen/mapScreen/mapScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buzzcab/featuresRider/screen/bookRides/ridebook_page.dart';
import 'package:buzzcab/featuresRider/screen/setting/rider_setting.dart';
import '../featuresDriver/Utils_Screen/SaveRide.dart';
import 'screen/homePage/homepage.dart';

class RiderNavigationMenu extends StatefulWidget {
  const RiderNavigationMenu({super.key});

  @override
  _RiderNavigationMenuState createState() => _RiderNavigationMenuState();
}

class _RiderNavigationMenuState extends State<RiderNavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SaveRide(),
    MapScreen(),
    const RiderSetting(),
    const DrawerPage(),
  ];

  void _onItemTapped(int index) {
    if (index >= 0 && index < _screens.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22.0),
          topRight: Radius.circular(22.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
            _buildNavItem('assets/icons/homepage/home-variant-outline.svg', 'Home', 0),
            _buildNavItem('assets/icons/homepage/saved.svg', 'Saved', 1),
            BottomNavigationBarItem(
              icon: _buildCenterButton(),
              label: '',
            ),
            _buildNavItem('assets/icons/homepage/cog-outline.svg', 'Settings', 3),
            _buildNavItem('assets/icons/homepage/account-circle-outline.svg', 'Profile', 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String assetPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: _buildIconWithBackground(assetPath, _selectedIndex == index),
      label: label,
    );
  }

  Widget _buildIconWithBackground(String assetPath, bool isSelected) {
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
        colorFilter: ColorFilter.mode(
          isSelected
              ? (Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white)
              : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
          BlendMode.srcIn,
        ),
        width: 24,
        height: 24,
        placeholderBuilder: (context) => const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => _onItemTapped(2),
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xFFD4D4D4),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/homepage/map-marker-distance.svg',
            width: 28,
            height: 28,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
