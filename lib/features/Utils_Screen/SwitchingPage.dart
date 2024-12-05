import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Constant/Utils_Button.dart';

class SwitchingPage extends StatefulWidget {
  const SwitchingPage({super.key});

  @override
  State<SwitchingPage> createState() => _SwitchingPageState();
}

class _SwitchingPageState extends State<SwitchingPage> {
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
              child: Lottie.asset(
                'assets/images/animations/Animation_for_Switching_User_t_ Driver_Mode.json',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "Switching to Rider Mode",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor, fontSize: 23),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Wait while we switch to Rider (user) Mode.....",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: textColor, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
