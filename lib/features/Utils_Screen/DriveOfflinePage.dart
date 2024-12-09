import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
                child:
                    SvgPicture.asset("assets/images/content/Group 1575.svg")),
            const SizedBox(
              height: 30,
            ),
            Text(
              "You’re in Offline Mode",
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: textColor, fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Press On Online Mode, to Go Active and Find new Active rides.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    fontSize: 14),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
