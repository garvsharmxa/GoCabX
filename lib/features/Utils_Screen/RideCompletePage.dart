import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Constant/Utils_Button2.dart';
import '../../Constant/Utils_Button3.dart';
import '../home/widgets/bottomButton.dart';

class RideCompletePage extends StatefulWidget {
  const RideCompletePage({super.key});

  @override
  State<RideCompletePage> createState() => _RideCompletePageState();
}

class _RideCompletePageState extends State<RideCompletePage> {
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
                child: SvgPicture.asset(
                    "assets/images/content/Ride Completion Animation.svg")),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Your Ride is Complete!",
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: textColor, fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "We hope you enjoyed the journey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    fontSize: 14),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 90,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xff262626)
                      : const Color(0xffEEE6F5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Aligns items vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligns items horizontally
                    children: [
                      Text(
                        "Thank you for riding with BuzzCabs!",
                        textAlign: TextAlign
                            .start, // Aligns text within the Text widget
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Adds spacing between the texts
                      Text(
                        "You can rate your driver and share feedback to help us improve.",
                        textAlign: TextAlign
                            .start, // Aligns text within the Text widget
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
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
                text: 'RATE YOUR RIDE',
                press: () {},
                fontSize: 12.5,
              ),
            ),
            Expanded(
              child: UtilsButton3(
                text: 'GO TO HOME',
                press: () {},
                color: Colors.white,
                FontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
