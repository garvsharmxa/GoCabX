import 'package:flutter/material.dart';

class HeaderWithProfile extends StatelessWidget {
  const HeaderWithProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/seed/375/600'),
              radius: 25,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Sub name', style: TextStyle(fontSize: 10)),
              ],
            ),
            Spacer(),
            Icon(Icons.notifications_outlined),
          ],
        ),
      
      ],
    );
  }
}
