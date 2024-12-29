import 'package:buzzcab/featuresDriver/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../rideRequest/ride_request_homepage.dart';

class DriverRegistrationComp extends StatefulWidget {
  const DriverRegistrationComp({super.key});

  @override
  State<DriverRegistrationComp> createState() => _DriverRegistrationCompState();
}

class _DriverRegistrationCompState extends State<DriverRegistrationComp> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body:  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Registration Completed!",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.5),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You’re Ready to Go on as a Roadie Now!",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.5),
            ),
            SizedBox(
              height: 50,
            ),
            Center(child: SvgPicture.asset("assets/images/content/Group 547.svg"))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [const Color(0xFF211F96), const Color(0xFF211F96)]
                  : [const Color(0xFF211F96), const Color(0xFF211F96)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
            ),
            child: Center(
              child: Text(
                "GO TO HOME",
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.grey[200] : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
