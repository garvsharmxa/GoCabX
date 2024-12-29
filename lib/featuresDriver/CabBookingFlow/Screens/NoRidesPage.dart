import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoRidesPage extends StatefulWidget {
  const NoRidesPage({super.key});

  @override
  State<NoRidesPage> createState() => _NoRidesPageState();
}

class _NoRidesPageState extends State<NoRidesPage> {
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SvgPicture.asset(
                  "assets/images/content/Empty street-cuate 1.svg")),
          SizedBox(
            height: 10,
          ),
          Text(
            "No Rides Available",
            style: TextStyle(
                fontWeight: FontWeight.w800, color: textColor, fontSize: 25),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10),
            child: Text(
              textAlign: TextAlign.center,
              "We're sorry, but there are no rides available at the moment.",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: textColor, fontSize: 17),
            ),
          ),
        ],
      )),
    );
  }
}
