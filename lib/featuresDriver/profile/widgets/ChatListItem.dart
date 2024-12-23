import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final bool isRead;
  final VoidCallback onTap;

  ChatListItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            'assets/images/content/profile.png'), // Replace with your asset image
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        lastMessage,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.24,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF979797),
              fontSize: 12.0,
            ),
          ),
          const Spacer(),
          isRead
              ? const Icon(Icons.check, color: Colors.green)
              : Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
