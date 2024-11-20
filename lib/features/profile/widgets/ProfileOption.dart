import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final IconData? lastIcon;

  const ProfileOption(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.lastIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1E7),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE2CE),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(icon, color: Colors.orange),
              ),
              const SizedBox(width: 16.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                lastIcon,
                color: const Color(0xFFFFE2CE),
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
