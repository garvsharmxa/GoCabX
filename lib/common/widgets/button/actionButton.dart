import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDarkMode;

  const ActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDarkMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode ? const Color(0xFF2E2E2E) : const Color(0xFFE6F5F3);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final iconColor = isDarkMode ? Color.fromARGB(255, 33, 7, 162) : Color.fromARGB(255, 17, 15, 151);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40.0, color: iconColor),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}