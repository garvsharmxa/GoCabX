import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Constant/Utils_Button2.dart';
import '../../Constant/Utils_Button3.dart';
import '../home/widgets/bottomButton.dart';

class RideCancelPage extends StatefulWidget {
  const RideCancelPage({super.key});

  @override
  State<RideCancelPage> createState() => _RideCancelPageState();
}

class _RideCancelPageState extends State<RideCancelPage> {
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
                child: SvgPicture.asset("assets/images/content/Frame 267.svg")),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Ride Cancelled!",
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: Colors.red, fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your ride has been successfully cancelled as per your request.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: UtilsButton2(
                text: 'FIND NEW RIDE',
                press: () {},
                fontSize: 14,
              ),
            ),
            Expanded(
              child: UtilsButton3(
                text: 'CONTACT US',
                press: () {},
                color: Colors.white,
                FontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
