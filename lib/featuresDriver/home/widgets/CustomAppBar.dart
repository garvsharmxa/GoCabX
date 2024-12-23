import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.ActionWidgets,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final List<Widget>? ActionWidgets;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF7F9FF),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage("assets/images/content/user.png"),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shruti Saini",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "Chandigarh University",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              )
            ],
          ),
        ],
      ),
      actions: ActionWidgets,
    );
  }
}
