import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils_Screen/DriveOfflinePage.dart';
import 'widgets/rideCard_DataModel.dart';
import 'widgets/rideCard_widiget.dart';
import 'widgets/switchModeWidget.dart';


class RideRequest extends StatefulWidget {
  const RideRequest({super.key});

  @override
  State<RideRequest> createState() => _RideRequestState();
}

class _RideRequestState extends State<RideRequest> {
  bool isOnlineMode = true; // Tracks the current mode

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Switch Mode Widget
              SwitchModeWidget(
                isOnlineMode: isOnlineMode,
                onModeChange: (mode) {
                  setState(() {
                    isOnlineMode = mode;
                  });
                },
              ),
              SizedBox(height: size.height * 0.02),
              // Show content based on the selected mode
              isOnlineMode ? _buildOnlineModeContent(size, isDarkMode) : const DriveOfflinePage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineModeContent(Size size, bool isDarkMode) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Rides',
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            'Current Rides and Details',
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.040,
              color: isDarkMode ? Colors.grey.shade300 : Colors.black54,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Expanded(
            child: ListView.builder(
              itemCount: rideData.length,
              itemBuilder: (context, index) {
                return RideCard(rideData[index], size);
              },
            ),
          ),
        ],
      ),
    );
  }
}
