import 'package:flutter/material.dart';
import 'modeButton.dart';

class SwitchModeWidget extends StatelessWidget {
  final bool isOnlineMode;
  final Function(bool) onModeChange;

  const SwitchModeWidget({
    super.key,
    required this.isOnlineMode,
    required this.onModeChange,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? const Color(0xFF1A1A1A) : Colors.white;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF101010) : Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.06),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.6)
                : Colors.grey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Row(
          key: ValueKey<bool>(isOnlineMode),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ModeButton(
              icon: Icons.wifi,
              text: 'ONLINE MODE',
              isSelected: isOnlineMode,
              activeColor: const Color(0xFF1F9686),
              inactiveColor: isDarkMode ? Colors.white : Colors.grey.shade800,
              size: size,
              onTap: () => onModeChange(true),
            ),
            ModeButton(
              icon: Icons.wifi_off,
              text: 'OFFLINE MODE',
              isSelected: !isOnlineMode,
              activeColor: const Color(0xFF211F96),
              inactiveColor: isDarkMode ? Colors.white : Colors.grey.shade800,
              size: size,
              onTap: () => onModeChange(false),
            ),
          ],
        ),
      ),
    );
  }
}
