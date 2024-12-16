import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;

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
                      Text("FAQs",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 27,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text("We're here to assist you!",
                          style: TextStyle(color: textColor, fontSize: 17)),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            SvgPicture.asset(
                                isDark
                                    ? "assets/images/content/Group 1514.svg"
                                    : "assets/images/content/Group 1514black.svg",
                                height: 150),
                            const SizedBox(height: 20),
                            Text("Need Help",
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text("Find answers for Frequently Asked Questions",
                                style:
                                    TextStyle(color: textColor, fontSize: 14)),
                          ],
                        ),
                      ),
                    ]))));
  }
}
