import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Constant/Utils_Button.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
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
                "assets/images/animations/f078240be4398f332e5a2eaaed88e9d0.gif",
                width: 300,
                height: 300,
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
