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
        child: Column(
          children: [
            // Custom App Bar Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SwitchModeWidget(
                isOnlineMode: isOnlineMode,
                onModeChange: (mode) {
                  setState(() {
                    isOnlineMode = mode;
                  });
                },
              ),
            ),

            // Main Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isOnlineMode
                          ? _buildOnlineModeContent(size, isDarkMode)
                          : const DriveOfflinePage(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineModeContent(Size size, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Container(
          margin: EdgeInsets.only(bottom: size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active Rides',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                  height: 1.2,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                'Available ride requests in real-time',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.038,
                  color: isDarkMode ? Colors.grey.shade400 : Colors.black54,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),

        // Rides List Container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade50,
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: rideData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: index != rideData.length - 1 ? size.height * 0.01 : 0,
                  ),
                  child: RideCard(rideData[index], size),
                );
              },
            ),
          ),
        ),

        // Add some bottom padding for better scrolling
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}

// Alternative version if you prefer to keep the AppBar structure
class RideRequestWithAppBar extends StatefulWidget {
  const RideRequestWithAppBar({super.key});

  @override
  State<RideRequestWithAppBar> createState() => _RideRequestWithAppBarState();
}

class _RideRequestWithAppBarState extends State<RideRequestWithAppBar> {
  bool isOnlineMode = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 20,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.01,
            ),
            child: SwitchModeWidget(
              isOnlineMode: isOnlineMode,
              onModeChange: (mode) {
                setState(() {
                  isOnlineMode = mode;
                });
              },
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isOnlineMode
                  ? _buildOnlineModeContent(size, isDarkMode)
                  : const DriveOfflinePage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineModeContent(Size size, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section with better spacing
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active Rides',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                  height: 1.2,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                'Available ride requests in real-time',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.038,
                  color: isDarkMode ? Colors.grey.shade400 : Colors.black54,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),

        // Enhanced Rides Container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDarkMode ? Colors.grey.shade900.withOpacity(0.5) : Colors.grey.shade50,
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(size.width * 0.02),
              itemCount: rideData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: index != rideData.length - 1 ? size.height * 0.01 : 0,
                  ),
                  child: RideCard(rideData[index], size),
                );
              },
            ),
          ),
        ),

        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}