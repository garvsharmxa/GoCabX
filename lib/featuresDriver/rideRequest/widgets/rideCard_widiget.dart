import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dot_line.dart';
import 'rideBook_cardWidget.dart';
import 'rideCard_DataModel.dart';

class RideCard extends StatelessWidget {
  final RideModel ride;
  final Size size;

  RideCard(this.ride, this.size);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      color: isDarkMode ? theme.cardColor : Colors.white,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New Label
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
                vertical: size.height * 0.005,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.blue.shade900 : Colors.blue.shade100,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              child: Text(
                'NEW',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? Colors.blue.shade300 : Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.035,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),

            // Time Left
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Left to Accept Ride',
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                    fontSize: size.width * 0.035,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                  ),
                  child: Text(
                    '${ride.timeLeft} sec',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            ClipRRect(
              borderRadius: BorderRadius.circular(size.width * 0.01),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor:
                    isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                color: Colors.green,
              ),
            ),
            SizedBox(height: size.height * 0.015),

            // Pickup and Drop-off Row
            Row(
              children: [
                LocationInfo(
                  icon: Icons.location_pin,
                  label: 'Pickup Location',
                  location: ride.pickupLocation,
                  size: size,
                  containerColor: const Color(0xFF1F9686),
                  iconColor: Colors.white,
                ),
                SizedBox(
                  height: size.height * 0.09, // Set desired height for the vertical line
                  child: const DottedLine(
                    direction: Axis.vertical,
                    dashWidth: 5,
                    dashHeight: 1,
                    spacing: 2,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                LocationInfo(
                  icon: Icons.location_pin,
                  label: 'Drop-off Location',
                  location: ride.dropOffLocation,
                  size: size,
                  containerColor: const Color(0xFF211F96),
                  iconColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            const DottedLine(
              direction: Axis.horizontal,
              dashWidth: 5,
              dashHeight: 1,
              spacing: 2,
              color: Colors.grey,
            ),
            SizedBox(height: size.height * 0.011),

            // Pickup Info and Ride Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoSection(
                  title: 'Pickup Info',
                  value: ride.pickupInfo,
                  size: size,
                ),
                SizedBox(
                  height: size.height * 0.05, // Set desired height for the vertical line
                  child: const DottedLine(
                    direction: Axis.vertical,
                    dashWidth: 5,
                    dashHeight: 1,
                    spacing: 2,
                    color: Colors.grey,
                  ),
                ),
                InfoSection(
                  title: 'Ride Info',
                  value: ride.rideInfo,
                  size: size,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            const DottedLine(
              direction: Axis.horizontal,
              dashWidth: 5,
              dashHeight: 1,
              spacing: 2,
              color: Colors.grey,
            ),

            // Ride Fare
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ride Fare',
                  style: GoogleFonts.poppins(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                    fontSize: size.width * 0.04,
                  ),
                ),
                Text(
                  '₹ ${ride.fare}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.02),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'ACCEPT RIDE',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                    ),
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.close,
                    size: size.width * 0.05,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
