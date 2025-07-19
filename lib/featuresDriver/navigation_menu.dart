import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'history/screens/HistoryScreen.dart';
import 'rideRequest/ride_request_homepage.dart';
import 'package:buzzcab/featuresRider/screen/setting/rider_setting.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.screens,
          )),
      bottomNavigationBar: Obx(
        () => Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black54 : Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF2a2a2a), const Color(0xFF1a1a1a)]
                      : [Colors.white, const Color(0xFFf5f5f5)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  controller.navItems.length,
                  (index) => _buildNavItem(
                    context,
                    controller,
                    index,
                    isDark,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavigationController controller,
    int index,
    bool isDark,
  ) {
    final isSelected = controller.selectedIndex.value == index;
    final navItem = controller.navItems[index];

    return GestureDetector(
      onTap: () => controller.selectedIndex.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:
              isSelected ? navItem.color.withOpacity(0.1) : Colors.transparent,
          border: isSelected
              ? Border.all(
                  color: navItem.color.withOpacity(0.3),
                  width: 1,
                )
              : null,
        ),
        child: SizedBox(
          height: 60,
          width: 60,// Set fixed height to avoid vertical overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected ? navItem.color : Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: navItem.color.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: SvgPicture.asset(
                  navItem.assetPath,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? Colors.white
                        : isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                    BlendMode.srcIn,
                  ),
                  width: 22,
                  height: 22,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  color: isSelected
                      ? navItem.color
                      : isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                child: Text(navItem.label, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const RideRequest(),
    const RiderSetting(),
  ];

  final List<NavItem> navItems = [
    NavItem('assets/icons/homepage/history.svg', 'History', Colors.teal),
    NavItem(
        'assets/icons/homepage/map-marker-distance.svg', 'Ride', Colors.green),
    NavItem('assets/icons/homepage/account-circle-outline.svg', 'Profile',
        Colors.purple),
  ];
}

class NavItem {
  final String assetPath;
  final String label;
  final Color color;

  NavItem(this.assetPath, this.label, this.color);
}
