import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.actionWidgets,
  });

  final List<Widget>? actionWidgets;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    // Get system brightness
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Theme colors based on system brightness
    final backgroundColor = isDarkMode
        ? const Color(0xFF1A202C)
        : const Color(0xFFF7F9FF);

    final titleTextColor = isDarkMode
        ? Colors.white
        : const Color(0xFF1A1A1A);

    final subtitleTextColor = isDarkMode
        ? const Color(0xFFA0AEC0)
        : const Color(0xFF757575);

    final iconColor = isDarkMode
        ? const Color(0xFFA0AEC0)
        : Colors.grey;

    final shadowColor = isDarkMode
        ? Colors.black.withOpacity(0.3)
        : Colors.black.withOpacity(0.05);

    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 3,
      shadowColor: shadowColor,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 3),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withOpacity(0.4)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                "https://garvsharmxa.netlify.app/assets/mypr-modified.png",
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Garv Sharma",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: titleTextColor,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    size: 16,
                    color: iconColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "GoCabX Driver • Sedan",
                    style: TextStyle(
                      color: subtitleTextColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: actionWidgets != null
          ? actionWidgets!.map((widget) {
        return Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: widget,
        );
      }).toList()
          : [],
    );
  }
}