import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriveOfflinePage extends StatefulWidget {
  const DriveOfflinePage({super.key});

  @override
  State<DriveOfflinePage> createState() => _DriveOfflinePageState();
}

class _DriveOfflinePageState extends State<DriveOfflinePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    final Color backgroundColor =
        Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : Colors.white;

    return Container(
      color: backgroundColor,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView( // Makes the content scrollable
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.01, // Adjust height for centering
            ),
            SvgPicture.asset(
              "assets/images/content/Group 1575.svg",
              height: size.height * 0.25, // Adjust height for scaling
            ),
            const SizedBox(height: 30),
            Text(
              "You’re in Offline Mode",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: textColor,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Press On Online Mode, to Go Active and Find new Active rides.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
