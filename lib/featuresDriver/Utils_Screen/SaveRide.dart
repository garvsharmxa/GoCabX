import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Constant/Utils_Button.dart';

class SaveRide extends StatefulWidget {
  const SaveRide({super.key});

  @override
  State<SaveRide> createState() => _SaveRideState();
}

class _SaveRideState extends State<SaveRide> {
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
      // appBar: AppBar(
      //   backgroundColor: backgroundColor,
      //   leading: IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.arrow_back,
      //         size: 27,
      //         color: textColor,
      //       )),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: SvgPicture.asset("assets/images/content/Group 53.svg")),
            const SizedBox(
              height: 30,
            ),
            Text(
              "No Saved Rides!",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor, fontSize: 28),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Your saved rides will appear here once you add",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: textColor, fontSize: 14),
            )
          ],
        ),
      ),
      bottomNavigationBar: UtilsButton(
        text: 'ADD SAVED PLACES',
        press: () {},
      ),
    );
  }
}
