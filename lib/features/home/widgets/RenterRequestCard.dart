import 'package:flutter/material.dart';

class RenterRequestCard extends StatelessWidget {
  const RenterRequestCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(
                    'assets/images/content/user.png'), // Replace with your asset image
              ),
              SizedBox(width: 8.0),
              Text(
                'Shruti Saini',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                'Rs 200/Hr',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Image.asset(
            'assets/images/content/Harrow.png', // Replace with your asset image
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Text(
                'Take Harrow on rent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                '2 days ago',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(Icons.message_rounded, color: Colors.orange),
              SizedBox(width: 8.0),
              Icon(Icons.location_on_rounded, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
