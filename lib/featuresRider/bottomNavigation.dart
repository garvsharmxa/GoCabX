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

class _RiderNavigationMenuState extends State<RiderNavigationMenu>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const SaveRide(),
  ];

  final List<NavItem> _navItems = [
    NavItem(
        'assets/icons/homepage/home-variant-outline.svg', 'Home', Colors.blue),
    NavItem(
        'assets/icons/homepage/map-marker-distance.svg', 'Map', Colors.green),
    NavItem('assets/icons/homepage/saved.svg', 'Saved', Colors.purple),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _slideAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index >= 0 && index < _screens.length && index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - _slideAnimation.value)),
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.white.withOpacity(0.8),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? [
                              const Color(0xFF1a1a1a),
                              const Color(0xFF0f0f0f),
                            ]
                          : [
                              const Color(0xFFffffff),
                              const Color(0xFFf8f9fa),
                            ],
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        _navItems.length,
                        (index) => _buildNavItem(index, isDark),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(int index, bool isDark) {
    final isSelected = _selectedIndex == index;
    final navItem = _navItems[index];

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => _onItemTapped(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        navItem.color.withOpacity(0.8),
                        navItem.color.withOpacity(0.6),
                      ],
                    )
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: navItem.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: isSelected ? _scaleAnimation.value : 1.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      shape: BoxShape.circle,
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
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                    fontSize: isSelected ? 12 : 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(navItem.label),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NavItem {
  final String assetPath;
  final String label;
  final Color color;

  NavItem(this.assetPath, this.label, this.color);
}

// Alternative Modern Floating Action Button Style Navigation
class ModernFloatingNavigation extends StatefulWidget {
  final List<Widget> screens;
  final List<NavItem> navItems;

  const ModernFloatingNavigation({
    super.key,
    required this.screens,
    required this.navItems,
  });

  @override
  State<ModernFloatingNavigation> createState() =>
      _ModernFloatingNavigationState();
}

class _ModernFloatingNavigationState extends State<ModernFloatingNavigation>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _fabAnimationController.reset();
      _fabAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.black12,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        const Color(0xFF2a2a2a),
                        const Color(0xFF1a1a1a),
                      ]
                    : [
                        Colors.white,
                        const Color(0xFFf5f5f5),
                      ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.navItems.length,
                (index) => _buildFloatingNavItem(index, isDark),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingNavItem(int index, bool isDark) {
    final isSelected = _selectedIndex == index;
    final navItem = widget.navItems[index];

    return AnimatedBuilder(
      animation: _fabScaleAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => _onItemTapped(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isSelected
                  ? navItem.color.withOpacity(0.1)
                  : Colors.transparent,
              border: isSelected
                  ? Border.all(
                      color: navItem.color.withOpacity(0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  scale: isSelected ? _fabScaleAnimation.value * 1.1 : 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? navItem.color : Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: navItem.color.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
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
                      width: 20,
                      height: 20,
                    ),
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
                  child: Text(navItem.label),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
