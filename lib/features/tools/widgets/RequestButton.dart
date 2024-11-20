import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RequestButton extends StatefulWidget {
  const RequestButton({
    super.key,
  });

  @override
  State<RequestButton> createState() => _RequestButtonState();
}

class _RequestButtonState extends State<RequestButton> {
  void _showRequestOptions() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'निम्नलिखित में से चयन करें',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 16),
              _buildRequestOption(
                Iconsax.call,
                'कमपन से संपर्क करें',
              ),
              _buildRequestOption(
                Iconsax.user_search,
                'नजदीकी डीलर ढुंडे',
              ),
              _buildRequestOption(
                Iconsax.category,
                'आस पास से रेंट पर ले',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRequestOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(icon, color: Colors.orange),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Background color
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide.none,
        elevation: 0,
      ),
      onPressed: () {
        _showRequestOptions();
      },
      child: Text('Request', style: TextStyle(fontSize: 18)),
    );
  }
}
