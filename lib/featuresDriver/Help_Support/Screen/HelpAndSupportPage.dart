import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;

    Widget infoCard(String title, String email, String phone) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.grey.shade900, Colors.grey.shade800]
                  : [Colors.white, Colors.grey.shade300],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/Framesasa.svg", width: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(email, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/Framesasa-1.svg", width: 20),
                  const SizedBox(width: 8),
                  Text(phone, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {},
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Help & Support", style: TextStyle(color: textColor, fontSize: 27, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("We're here to help you!", style: TextStyle(color: textColor, fontSize: 17)),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/content/Group 1491.svg", height: 150),
                    const SizedBox(height: 20),
                    Text("How Can We Help You?", style: TextStyle(color: textColor, fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text("Facing a problem? Let us know.", style: TextStyle(color: textColor, fontSize: 15)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/container.svg", width: 25),
                          const SizedBox(width: 10),
                          Text("Live Chat", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: textColor, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  infoCard("Contact Us", "support@buzzcabs.com", "+91-96875 43210"),
                  infoCard("Report an Issue", "reportbug@buzzcabs.com", "+91-96875 43210"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
