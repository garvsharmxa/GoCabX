import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Constant/Utils_Button.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
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
            Center(
                child: SvgPicture.asset("assets/images/content/Group 54.svg")),
            const SizedBox(
              height: 50,
            ),
            Text(
              "404 Route Not Found :|",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor, fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Don't worry, we can get you back on track!",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: textColor, fontSize: 14),
            )
          ],
        ),
      ),
      bottomNavigationBar: UtilsButton(
        text: 'RELOAD',
        press: () {},
      ),
    );
  }
}
