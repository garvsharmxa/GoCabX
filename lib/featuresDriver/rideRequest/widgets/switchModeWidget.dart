import 'package:flutter/material.dart';
import 'modeButton.dart';

class SwitchModeWidget extends StatelessWidget {
  final bool isOnlineMode;
  final Function(bool) onModeChange; // Callback for mode change

  const SwitchModeWidget({
    super.key,
    required this.isOnlineMode,
    required this.onModeChange,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Determine colors based on light or dark theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? const Color(0xFF1A1A1A) : Colors.white;

    return Container(
      padding: EdgeInsets.only(top: size.width * 0.02,bottom: size.width * 0.02),
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(size.width * 0.06),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: size.width * 0.01,
            blurRadius: size.width * 0.03,
          ),
        ],
      ),
      // decoration: BoxDecoration(
      //   color: backgroundColor,
      //   borderRadius: BorderRadius.circular(size.width * 0.06),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ModeButton(
            icon: Icons.wifi,
            text: 'ONLINE MODE',
            isSelected: isOnlineMode,
            activeColor: const Color(0xFF1F9686),
            inactiveColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
            size: size,
            onTap: () => onModeChange(true), // Notify parent about mode change
          ),
          ModeButton(
            icon: Icons.wifi_off,
            text: 'OFFLINE MODE',
            isSelected: !isOnlineMode,
            activeColor: const Color(0xFF211F96),
            inactiveColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
            size: size,
            onTap: () => onModeChange(false), // Notify parent about mode change
          ),
        ],
      ),
    );
  }
}
