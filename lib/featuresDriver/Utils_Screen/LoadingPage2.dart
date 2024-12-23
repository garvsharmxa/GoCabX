import 'package:flutter/material.dart';

import '../../Constant/Utils_Button.dart';

class LoadingPage2 extends StatefulWidget {
  const LoadingPage2({super.key});

  @override
  State<LoadingPage2> createState() => _LoadingPage2State();
}

class _LoadingPage2State extends State<LoadingPage2> {
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
              child: Image.asset(
                "assets/images/animations/Car_loading .gif",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "Please wait while Loading...",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor, fontSize: 23),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please wait for sometime",
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
